# Release Notes Template

## rmguard v{VERSION}

**Release Date**: {DATE}

---

## 📦 Installation

### Method 1: Install .deb package (Recommended)

```bash
# Download
wget https://github.com/Happyuky7/RMGUARD-Linux/releases/download/v{VERSION}/rmguard_{VERSION}_all.deb

# Install
sudo apt install ./rmguard_{VERSION}_all.deb

# Activate (only once in current session)
source /etc/profile

# Verify
rmguard --version
```

### Method 2: Git clone

```bash
git clone -b v{VERSION} https://github.com/Happyuky7/RMGUARD-Linux.git
cd RMGUARD-Linux/scripts
sudo ./install.sh
source /etc/profile
```

---

## 🎯 What's New

### ✨ New Features
- {Feature 1 description}
- {Feature 2 description}

### 🐛 Bug Fixes
- {Bug fix 1 description}
- {Bug fix 2 description}

### 🔧 Improvements
- {Improvement 1 description}
- {Improvement 2 description}

### 📝 Documentation
- {Documentation update 1}
- {Documentation update 2}

---

## 🔄 Upgrade Instructions

### From previous version:

**Option A: Using rmguard CLI (Automatic)**
```bash
rmguard --check-updates
# Answer 'y' when prompted
```

**Option B: Manual upgrade**
```bash
# If installed via .deb:
wget https://github.com/Happyuky7/RMGUARD-Linux/releases/download/v{VERSION}/rmguard_{VERSION}_all.deb
sudo apt install ./rmguard_{VERSION}_all.deb

# If installed via git:
cd /path/to/RMGUARD-Linux
git pull
git checkout v{VERSION}
cd scripts
sudo ./install.sh
```

---

## 📋 Commands Reference

| Command | Alias | Description |
|---------|-------|-------------|
| `rmguard --help` | `-h` | Show help menu |
| `rmguard --version` | `-v` | Show version |
| `rmguard --status` | `-s` | Check if active |
| `rmguard --check-updates` | `-c` | Check and install updates |

---

## 🔒 Security Notes

- rmguard protects against dangerous `rm` commands
- Only active in interactive shells (won't break system scripts)
- Can be bypassed with `RM_GUARD=0` or `--no-guard` when needed

---

## 📊 Compatibility

- ✅ **Tested on**: Ubuntu 20.04, 22.04, 24.04
- ✅ **Tested on**: Debian 10, 11, 12
- ✅ **Shell**: Bash (interactive shells)
- ⚠️ **Note**: Not tested on other distributions (should work on any Linux with bash)

---

## 🐛 Known Issues

{List any known issues or limitations}

---

## 📝 Changelog

### Version {VERSION}

**Added**
- {New feature 1}
- {New feature 2}

**Changed**
- {Changed behavior 1}
- {Changed behavior 2}

**Fixed**
- {Bug fix 1}
- {Bug fix 2}

**Deprecated**
- {Deprecated feature if any}

**Removed**
- {Removed feature if any}

---

## 🙏 Contributors

Thanks to everyone who contributed to this release!

- @{contributor1}
- @{contributor2}

---

## 📚 Documentation

- [English README](https://github.com/Happyuky7/RMGUARD-Linux/blob/main/README.md)
- [Spanish README](https://github.com/Happyuky7/RMGUARD-Linux/blob/main/README.es.md)
- [Installation Guide](https://github.com/Happyuky7/RMGUARD-Linux#-installation)
- [Commands Reference](https://github.com/Happyuky7/RMGUARD-Linux#-commands)

---

## 💬 Support

- 🐛 [Report a bug](https://github.com/Happyuky7/RMGUARD-Linux/issues/new)
- 💡 [Request a feature](https://github.com/Happyuky7/RMGUARD-Linux/issues/new)
- 📖 [Read the docs](https://github.com/Happyuky7/RMGUARD-Linux#readme)

---

## 📦 Assets

**Files in this release:**

- `rmguard_{VERSION}_all.deb` - Debian package (recommended)
- `Source code (zip)` - Source code archive
- `Source code (tar.gz)` - Source code archive

**SHA256 Checksums:**
```
{CHECKSUM}  rmguard_{VERSION}_all.deb
```

---

**Full Changelog**: https://github.com/Happyuky7/RMGUARD-Linux/compare/v{PREVIOUS_VERSION}...v{VERSION}
