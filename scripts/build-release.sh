#!/bin/bash
# Build release packages for ProtonDrive Linux

set -e

VERSION="1.1.0"
DIST_DIR="dist"

echo "Building ProtonDrive Linux v${VERSION} release packages..."

# Create dist directory
mkdir -p ${DIST_DIR}

# Build Python package
echo "Building Python package..."
python setup.py sdist bdist_wheel

# Build AUR package
echo "Building AUR package..."
makepkg -f
cp protondrive-linux-*.pkg.tar.zst ${DIST_DIR}/

# Create AppImage
echo "Creating AppImage..."
cat > AppImageBuilder.yml << EOF
version: 1
AppDir:
  path: ./AppDir
  app_info:
    id: io.github.donniedice.protondrive
    name: ProtonDrive
    icon: protondrive
    version: ${VERSION}
    exec: usr/bin/python3
    exec_args: -m protondrive
  runtime:
    env:
      PYTHONPATH: \$APPDIR/usr/lib/python3/dist-packages
  files:
    include:
      - usr/bin/python3
      - usr/lib/python3
      - usr/lib/x86_64-linux-gnu/libtk*.so*
      - usr/lib/x86_64-linux-gnu/libtcl*.so*
    exclude:
      - usr/share/man
      - usr/share/doc
  after_bundle:
    - cp -r protondrive \$TARGET_APPDIR/usr/lib/python3/dist-packages/
    - cp icons/protondrive.png \$TARGET_APPDIR/
AppImage:
  arch: x86_64
  file_name: ProtonDrive-${VERSION}-x86_64.AppImage
EOF

# Create DEB package
echo "Creating DEB package..."
mkdir -p debian-build/DEBIAN
mkdir -p debian-build/usr/bin
mkdir -p debian-build/usr/share/applications
mkdir -p debian-build/usr/share/pixmaps
mkdir -p debian-build/usr/lib/python3/dist-packages

cat > debian-build/DEBIAN/control << EOF
Package: protondrive-linux
Version: ${VERSION}
Section: utils
Priority: optional
Architecture: all
Depends: python3, python3-tk, rclone
Maintainer: donniedice <donniedice@protonmail.com>
Description: ProtonDrive Linux GUI Client
 Premium unofficial client for ProtonDrive with Proton's signature design.
 Features include folder sync, file browsing, and drive mounting.
EOF

cp -r protondrive debian-build/usr/lib/python3/dist-packages/
cp icons/protondrive.png debian-build/usr/share/pixmaps/
cp protondrive-linux.desktop debian-build/usr/share/applications/

cat > debian-build/usr/bin/protondrive-gui << 'EOF2'
#!/usr/bin/env python3
from protondrive import main
if __name__ == "__main__":
    main()
EOF2
chmod +x debian-build/usr/bin/protondrive-gui

dpkg-deb --build debian-build ${DIST_DIR}/protondrive-linux_${VERSION}_all.deb

# Create RPM package
echo "Creating RPM spec file..."
cat > protondrive-linux.spec << EOF
Name:           protondrive-linux
Version:        ${VERSION}
Release:        1%{?dist}
Summary:        ProtonDrive Linux GUI Client

License:        GPLv3+
URL:            https://github.com/donniedice/protondrive-linux
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools
Requires:       python3
Requires:       python3-tkinter
Requires:       rclone

%description
Premium unofficial client for ProtonDrive with Proton's signature design.
Features include folder sync, file browsing, and drive mounting.

%prep
%autosetup

%build
%py3_build

%install
%py3_install
install -Dm644 protondrive-linux.desktop %{buildroot}%{_datadir}/applications/protondrive-linux.desktop
install -Dm644 icons/protondrive.png %{buildroot}%{_datadir}/pixmaps/protondrive.png

%files
%license LICENSE
%doc README.md CHANGELOG.md
%{python3_sitelib}/*
%{_bindir}/protondrive-gui
%{_datadir}/applications/protondrive-linux.desktop
%{_datadir}/pixmaps/protondrive.png

%changelog
* $(date +"%a %b %d %Y") donniedice <donniedice@protonmail.com> - ${VERSION}-1
- Release v${VERSION} with premium Proton design
EOF

echo "Build complete! Packages available in ${DIST_DIR}/"
ls -la ${DIST_DIR}/