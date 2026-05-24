# rmguard

[🇪🇸 Español](README.es.md) | [🇨🇳 简体中文](README.zh-CN.md) | 🇬🇧 English

**rmguard** protects against dangerous `rm` commands (e.g., `rm -f /*` or `rm -rf /etc`) without breaking system scripts.  
It loads only in interactive shells (e.g., when a person is on SSH/TTY) and allows explicit forcing if you really need it.

## 🔒 Features

- ✅ **Blocks deletion of** `"/"` and top-level paths (`/bin`, `/etc`, `/var`, …).
- ✅ **Allows by default** `/tmp` and `/var/tmp` (configurable).
- ✅ **Does not replace** `/bin/rm`: defines an `rm` function that calls `/usr/lib/rmguard/rmguard`.
- ✅ **To force**: `RM_GUARD=0 rm …` or `rm --no-guard …`.

⚠️ **Note**: if a script invokes `/bin/rm` with absolute path or uses `command rm`, it won't go through rmguard. Recommendation: in your scripts use `rm` without path.

---

## 📋 Table of Contents

- [Installation](#installation)
- [Getting Started](docs/GETTING_STARTED.md)
- [Usage](#usage)
- [Commands](#commands)
- [Configuration](#configuration)
- [Testing](#testing)
- [Uninstallation](#uninstallation)
- [Design and Decisions](#design-and-decisions)
- [Troubleshooting](#troubleshooting)
- [Project Structure](#project-structure)
- [License](#license)

---

## 🚀 Installation

**⚠️ Important**: Once installed, rmguard will be **automatically active** in all new interactive sessions (SSH, terminal). You only need to run `source /etc/profile` **once** to activate it in the current session after installation.

### Method 1: Manual installation (git clone)

```bash
git clone https://github.com/Happyuky7/RMGUARD-Linux.git
cd RMGUARD-Linux/scripts
sudo ./install.sh
# Activate it in the current session or open a new one:
source /etc/profile
```

### Method 2: Install from .deb package

Download the latest `.deb` package from [Releases](https://github.com/Happyuky7/RMGUARD-Linux/releases) and install:

```bash
# Download the latest release
wget https://github.com/Happyuky7/RMGUARD-Linux/releases/latest/download/rmguard_0.0.1_all.deb

# Install
sudo apt install ./rmguard_0.0.1_all.deb

# Activate it in the current session (only once)
source /etc/profile
```

### ✅ Verify installation

```bash
# Check if rmguard is active
rmguard --status

# Or verify manually
type rm
# Should show: rm is a shell function
```

---

## 💻 Usage

Same as always:

```bash
rm -rf folder
```

If you try something risky:

```bash
rm -f /*         # → blocked
rm -rf /etc      # → blocked
```

To force (only if you know what you're doing):

```bash
RM_GUARD=0 rm -rf /etc
# or:
rm --no-guard -rf /etc
```

---

## 🛠️ Commands

### Show help

```bash
rmguard --help
# or
rmguard -h
```

### Show version

```bash
rmguard --version
# or
rmguard -v
```

### Check rmguard status

```bash
rmguard --status
# or
rmguard -s
```

### Check for updates

```bash
rmguard --check-updates
# or
rmguard -c

# If an update is available, it will ask if you want to install it
```

### Complete command list

| Command | Alias | Description |
|---------|-------|-------------|
| `rmguard --help` | `-h` | Show complete help menu |
| `rmguard --version` | `-v` | Show installed version |
| `rmguard --status` | `-s` | Check if rmguard is active |
| `rmguard --check-updates` | `-c` | Check for updates and install them |

### Disable rmguard temporarily

```bash
# Option 1: For a specific command
RM_GUARD=0 rm -rf /dangerous/path

# Option 2: Use --no-guard flag
rm --no-guard -rf /dangerous/path

# Option 3: Disable in current session
unset -f rm
export RM_GUARD=0
```

---

## ⚙️ Configuration

**File**: `/etc/rmguard.conf`

```bash
# Disable globally (not recommended)
# RM_GUARD=0

# Allowed toplevels (default /tmp and /var/tmp)
ALLOW_TOPLEVEL="/tmp /var/tmp"
```

---

## 🧪 Testing

```bash
# Blocks top-level paths
rm -rf /etc || echo "OK: blocked /etc"

# Allows /tmp
touch /tmp/x && rm -f /tmp/x && echo "OK: /tmp allowed"

# Automated test:
sudo bash ./test/rmguard_test.sh
```

---

## 🗑️ Uninstallation

```bash
cd rmguard/scripts
sudo ./uninstall.sh
```

---

## 🏗️ Design and Decisions

1. **Interactive shells only**: loaded through `/etc/profile.d`, avoiding breaking system services or scripts.
2. **Does not touch or replace `/bin/rm`**: exposes an `rm()` function that invokes `/usr/lib/rmguard/rmguard`.
3. **Safe blocking by default**: prevents `"/"` and top-level paths (e.g. `/bin`, `/etc`, `/var`), except a configurable whitelist (`/tmp`, `/var/tmp`).
4. **Explicitly forceable**: `RM_GUARD=0` or `--no-guard` when you need to execute something exceptional and conscious.
5. **Friendly alias**: `-I` and `--preserve-root=all` add positive friction; they don't replace guard rules.
6. **Persistent**: Once installed, it activates automatically in every new session without additional configuration.

---

## 🔄 Automatic Operation

### ✅ rmguard activates automatically in:
- New opened terminals
- SSH sessions
- Interactive bash shells
- After system reboots

### ❌ rmguard does NOT activate in:
- System scripts (to avoid breaking services)
- Cron jobs
- Systemd services
- Scripts that use `/bin/rm` with absolute path

### 📋 Check if it's active

```bash
# Method 1: Use status command
rmguard --status

# Method 2: Check manually
type rm
# Expected output: "rm is a shell function"

# Method 3: Check environment variable
echo $RM_GUARD
# Expected output: 1 (active) or empty/0 (inactive)
```

---

## 🔧 Troubleshooting

### "My script doesn't go through rmguard"
If it uses `/bin/rm` (absolute path) or `command rm`, it bypasses the shell function. **Recommendation**: in your own scripts use `rm` without path.

### "rmguard doesn't activate after install"
Open a new session or run `source /etc/profile`. Verify with:

```bash
type rm   # should show: rm is a shell function …
```

### "I need to allow another top-level path"
Edit `/etc/rmguard.conf` and add to `ALLOW_TOPLEVEL` (⚠️ carefully).

### "How do I disable rmguard temporarily?"
See section [Disable rmguard temporarily](#disable-rmguard-temporarily) in Commands.

### "Will rmguard be active after reboot?"
Yes, rmguard activates automatically in every new session after installation. You don't need to reconfigure it.

---

## � Project Structure

```
rmguard/
├─ src/
│  └─ rmguard                 # main binary (wrapper)
├─ etc/
│  └─ profile.d/
│     └─ rmguard.sh           # activates rmguard in interactive shells
├─ config/
│  └─ rmguard.conf            # optional config (whitelist toplevels)
├─ scripts/
│  ├─ install.sh              # manual installation (git clone)
│  ├─ uninstall.sh            # manual uninstallation
│  └─ package.sh              # generates rmguard_0.0.1_all.deb
├─ test/
│  └─ rmguard_test.sh         # quick tests
├─ README.md                  # documentation (English)
├─ README.es.md               # documentation (Spanish)
├─ README.zh-CN.md            # documentation (Simplified Chinese)
└─ LICENSE
```

---

## �📄 License

**MIT License** — See [LICENSE](LICENSE) file for more details.

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the project
2. Create a branch for your feature (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## � Building .deb Package

If you want to build the `.deb` package yourself:

```bash
cd rmguard/scripts
./package.sh 0.0.1

# The package will be created at:
# build/rmguard_0.0.1_all.deb
```

For creating releases:

```bash
./scripts/release.sh 0.0.1
```

---

## � Future Implementations

- 🚧 **APT Repository**: Publication in official repository for easier installation
- 🚧 **Auto-updates via APT**: Automatic system updates

---

## ⚠️ Warning

This software is an additional protection layer but is **NOT** infallible. Always be careful when running destructive commands on production systems.

---

**Developed with ❤️ by [Happyuky7](https://github.com/Happyuky7) to protect your Linux systems**
