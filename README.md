# ProtonDrive Linux Client

[![GitHub Release](https://img.shields.io/github/v/release/donniedice/protondrive-linux)](https://github.com/donniedice/protondrive-linux/releases)
[![AUR Version](https://img.shields.io/aur/version/protondrive-linux)](https://aur.archlinux.org/packages/protondrive-linux)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![CI/CD](https://github.com/donniedice/protondrive-linux/actions/workflows/ci.yml/badge.svg)](https://github.com/donniedice/protondrive-linux/actions)

An unofficial Linux desktop client for ProtonDrive, built with Python and Tkinter. This client provides a simple GUI interface for managing your ProtonDrive files on Linux systems.

## 🚀 Features

- 🔐 **Secure Authentication** - ProtonMail credentials with rclone backend
- 📁 **Sync Folders** - Bi-directional sync between local and ProtonDrive
- 🔍 **Browse Files** - Navigate your ProtonDrive storage
- 💾 **Mount as Drive** - Access ProtonDrive as local filesystem
- 🖥️ **Native GUI** - Built with Tkinter for lightweight performance
- 🐧 **Desktop Integration** - System tray, notifications, and .desktop file

## 📦 Installation

### Official Packages

#### Arch Linux (AUR)
```bash
yay -S protondrive-linux
# or
paru -S protondrive-linux
```

#### Flatpak (All Distros)
```bash
flatpak install flathub io.github.donniedice.protondrive
flatpak run io.github.donniedice.protondrive
```

#### AppImage (All Distros)
```bash
wget https://github.com/donniedice/protondrive-linux/releases/latest/download/ProtonDrive-x86_64.AppImage
chmod +x ProtonDrive-x86_64.AppImage
./ProtonDrive-x86_64.AppImage
```

#### Ubuntu/Debian (PPA)
```bash
sudo add-apt-repository ppa:donniedice/protondrive
sudo apt update
sudo apt install protondrive-linux
```

#### Fedora (COPR)
```bash
sudo dnf copr enable donniedice/protondrive
sudo dnf install protondrive-linux
```

### From Source
```bash
# Clone repository
git clone https://github.com/donniedice/protondrive-linux.git
cd protondrive-linux

# Install dependencies
pip install -r requirements.txt

# Install
pip install -e .

# Run
protondrive-gui
```

## 🔧 Requirements

- **OS**: Linux (any distribution)
- **Python**: 3.8+
- **Dependencies**:
  - rclone (auto-installed)
  - python3-tk
  - python3-pip

## 📖 Usage

1. **Launch**: Run `protondrive-gui` from terminal or application menu
2. **Configure**: Enter your ProtonMail credentials
3. **Connect**: Click "Configure ProtonDrive"
4. **Use**:
   - **Sync**: Select local folder to sync
   - **Browse**: View ProtonDrive contents
   - **Mount**: Mount as local drive

## 🛠️ Development

### Building from Source

```bash
# Clone with submodules
git clone --recursive https://github.com/donniedice/protondrive-linux.git
cd protondrive-linux

# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install development dependencies
pip install -r requirements-dev.txt

# Run tests
pytest

# Build package
python setup.py sdist bdist_wheel
```

### CI/CD Pipeline

This project uses GitHub Actions for:
- ✅ Automated testing on multiple Python versions
- ✅ Code quality checks (flake8, black)
- ✅ Security scanning
- ✅ Package building for multiple formats
- ✅ Automatic releases to GitHub, AUR, Flatpak

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md).

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 🔒 Security

- Uses rclone's encrypted configuration
- No credentials stored in plaintext
- All communication via HTTPS
- Regular security audits via GitHub Actions

## 📊 Project Status

- ✅ **Core Features**: Complete
- ✅ **AUR Package**: Available
- 🚧 **Flatpak**: In Progress
- 🚧 **Snap Package**: Planned
- 🚧 **Official Support**: Awaiting Proton response

## 📝 License

This project is licensed under the GNU General Public License v3.0 - see [LICENSE](LICENSE) file.

## 🙏 Acknowledgments

- [Proton](https://proton.me) for ProtonDrive service
- [rclone](https://rclone.org) for backend implementation
- Community contributors

## ⚠️ Disclaimer

This is an **unofficial** client not affiliated with Proton AG. For official support, use:
- [ProtonDrive Web](https://drive.proton.me)
- [Official Mobile Apps](https://proton.me/drive/download)

---

**Made with ❤️ for the Linux community while we wait for official support**