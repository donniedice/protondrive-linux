Name:           protondrive-linux
Version:        1.0.0
Release:        1%{?dist}
Summary:        ProtonDrive Linux GUI Client

License:        GPL-3.0
URL:            https://github.com/donniedice/protondrive-linux
Source0:        %{url}/archive/v%{version}/%{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools

Requires:       python3
Requires:       python3-tkinter
Requires:       rclone

%description
Unofficial desktop client for ProtonDrive on Linux.
Features sync, browse, and mount functionality via rclone backend.

%prep
%autosetup

%build
%py3_build

%install
%py3_install

%files
%license LICENSE
%doc README.md
%{python3_sitelib}/protondrive/
%{python3_sitelib}/protondrive_linux*.egg-info/
%{_bindir}/protondrive-gui

%changelog
* Mon Jul 21 2025 donniedice <donniedice@protonmail.com> - 1.0.0-1
- Initial release