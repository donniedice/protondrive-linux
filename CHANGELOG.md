# Changelog

All notable changes to ProtonDrive Linux Client will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-07-21

### Added
- Premium Proton-themed GUI with dark mode design
- Full 2FA (two-factor authentication) support
- Status indicator showing connection state
- Activity log with color-coded messages
- Manual configuration script for troubleshooting
- Launcher script for easier execution
- Comprehensive troubleshooting documentation

### Changed
- Complete UI redesign matching Proton's design language
- Improved error handling and user feedback
- Enhanced security with password field clearing after login
- Better connection status checking

### Fixed
- Password encoding issues with rclone
- "Username and password are required" error
- Module execution errors
- Virtual environment PATH issues

## [1.0.2] - 2025-07-21

### Fixed
- 2FA authentication support
- Password obscuring implementation

## [1.0.1] - 2025-07-20

### Fixed
- Removed tkinter from pip dependencies (it's included with Python)

## [1.0.0] - 2025-07-20

### Added
- Initial release
- Basic GUI for ProtonDrive using rclone backend
- Sync folders functionality
- Browse ProtonDrive files
- Mount as local drive
- Desktop integration (.desktop file)
- Multiple distribution packages (AUR, DEB, RPM, Flatpak, AppImage)
- GitHub Actions CI/CD pipeline