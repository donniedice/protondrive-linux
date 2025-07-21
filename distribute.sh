#!/bin/bash
# Complete distribution script for ProtonDrive Linux Client

set -e

echo "🚀 ProtonDrive Linux Distribution Script"
echo "========================================"

VERSION="1.0.0"
REPO="donniedice/protondrive-linux"

# Function to check command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Build source distribution
echo "📦 Building source distribution..."
python -m build

# Build AppImage
if command_exists appimagetool; then
    echo "📦 Building AppImage..."
    mkdir -p AppDir/usr/bin AppDir/usr/share/applications AppDir/usr/share/icons/hicolor/256x256/apps
    
    pip install --target AppDir/usr/lib/python3 .
    echo '#!/bin/bash
    export PYTHONPATH="${APPDIR}/usr/lib/python3:${PYTHONPATH}"
    exec python3 -m protondrive "$@"' > AppDir/usr/bin/protondrive-gui
    chmod +x AppDir/usr/bin/protondrive-gui
    
    cp protondrive-linux.desktop AppDir/
    cp icons/protondrive.png AppDir/usr/share/icons/hicolor/256x256/apps/
    
    appimagetool AppDir ProtonDrive-${VERSION}-x86_64.AppImage
fi

# Build DEB package
if command_exists dpkg-deb; then
    echo "📦 Building DEB package..."
    mkdir -p debian/DEBIAN debian/usr/bin debian/usr/share/applications debian/usr/share/pixmaps
    
    cp packaging/debian/control debian/DEBIAN/
    python3 setup.py install --root=debian --prefix=/usr
    cp protondrive-linux.desktop debian/usr/share/applications/
    cp icons/protondrive.png debian/usr/share/pixmaps/
    
    dpkg-deb --build debian protondrive-linux_${VERSION}_all.deb
fi

# Build RPM package
if command_exists rpmbuild; then
    echo "📦 Building RPM package..."
    mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
    
    tar czf ~/rpmbuild/SOURCES/protondrive-linux-${VERSION}.tar.gz --transform "s,^,protondrive-linux-${VERSION}/," *
    cp packaging/fedora/protondrive-linux.spec ~/rpmbuild/SPECS/
    
    rpmbuild -ba ~/rpmbuild/SPECS/protondrive-linux.spec
fi

# Update AUR
echo "📦 Updating AUR package..."
if [ -d "../aur-protondrive-linux" ]; then
    cd ../aur-protondrive-linux
    # Update PKGBUILD version
    sed -i "s/pkgver=.*/pkgver=${VERSION}/" PKGBUILD
    makepkg --printsrcinfo > .SRCINFO
    echo "AUR package ready for submission in ../aur-protondrive-linux"
    cd -
fi

# Create release archive
echo "📦 Creating release archive..."
tar czf protondrive-linux-${VERSION}.tar.gz \
    --exclude='.git' \
    --exclude='*.pyc' \
    --exclude='__pycache__' \
    --exclude='*.egg-info' \
    --exclude='build' \
    --exclude='dist' \
    --exclude='pkg' \
    --exclude='src' \
    *

echo ""
echo "✅ Distribution packages created:"
echo "   - dist/*.whl (Python wheel)"
echo "   - dist/*.tar.gz (Python source)"
[ -f "ProtonDrive-${VERSION}-x86_64.AppImage" ] && echo "   - ProtonDrive-${VERSION}-x86_64.AppImage"
[ -f "protondrive-linux_${VERSION}_all.deb" ] && echo "   - protondrive-linux_${VERSION}_all.deb"
[ -f "~/rpmbuild/RPMS/noarch/protondrive-linux-${VERSION}-1.noarch.rpm" ] && echo "   - RPM package in ~/rpmbuild/RPMS/"
echo "   - protondrive-linux-${VERSION}.tar.gz (release archive)"
echo ""
echo "📤 Ready for distribution to:"
echo "   - GitHub Releases"
echo "   - PyPI (pip)"
echo "   - AUR"
echo "   - Ubuntu PPA"
echo "   - Fedora COPR"
echo "   - Flatpak"
echo "   - Snap Store"