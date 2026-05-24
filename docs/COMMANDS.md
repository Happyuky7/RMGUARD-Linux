# rmguard - Command Reference

Complete list of all available commands and options.

---

## 📖 Table of Contents

- [Main Commands](#main-commands)
- [rm Command (Protected)](#rm-command-protected)
- [Bypass Methods](#bypass-methods)
- [Environment Variables](#environment-variables)
- [Configuration File](#configuration-file)

---

## Main Commands

### `rmguard --help` / `rmguard -h`

Shows the complete help menu.

**Usage:**
```bash
rmguard --help
rmguard -h
```

**Output:**
- Command usage
- Available options
- Configuration instructions
- Bypass methods
- Repository links

---

### `rmguard --version` / `rmguard -v`

Shows the current installed version.

**Usage:**
```bash
rmguard --version
rmguard -v
```

**Output:**
- Version number
- Copyright information
- License (MIT)
- Repository URL

---

### `rmguard --status` / `rmguard -s`

Checks if rmguard is active and properly installed.

**Usage:**
```bash
rmguard --status
rmguard -s
```

**Checks:**
- ✅ Binary installation (`/usr/lib/rmguard/rmguard`)
- ✅ Profile script (`/etc/profile.d/rmguard.sh`)
- ✅ Config file (`/etc/rmguard.conf`)
- ✅ Active in current shell
- ✅ Current `RM_GUARD` value

---

### `rmguard --check-updates` / `rmguard -c`

Checks for available updates on GitHub.

**Usage:**
```bash
rmguard --check-updates
rmguard -c
```

**Features:**
- Queries GitHub API for latest release
- Compares with current version
- Offers automatic installation if update available
- Downloads and installs automatically if confirmed
- Shows release notes link

**Example:**
```bash
$ rmguard --check-updates
Checking for updates...
Current version: 0.0.1
Latest version:  0.0.2

🔔 New version available: 0.0.2

Release notes: https://github.com/Happyuky7/RMGUARD-Linux/releases/latest

Do you want to install this update now? (y/N): y

📦 Installing update...
[Installation process...]
✅ Update completed successfully!
```

---

## rm Command (Protected)

When rmguard is active, the `rm` command is protected.

### Normal Usage

```bash
rm file.txt                    # Works normally
rm -r directory/               # Works normally
rm -f *.tmp                    # Works normally
rm /tmp/test.txt               # Works normally (allowed path)
```

### Blocked Commands

```bash
rm -rf /                       # ❌ BLOCKED
rm -rf /etc                    # ❌ BLOCKED
rm -rf /bin                    # ❌ BLOCKED
rm -rf /var                    # ❌ BLOCKED
rm -rf /usr                    # ❌ BLOCKED
rm --no-preserve-root /        # ❌ BLOCKED
```

### Protected Paths

By default, rmguard blocks:
- `/` (root)
- Any top-level directory (`/bin`, `/etc`, `/var`, `/usr`, `/home`, etc.)

**Exceptions (allowed by default):**
- `/tmp`
- `/var/tmp`

---

## Bypass Methods

### Method 1: Environment Variable

Disable rmguard for a single command:

```bash
RM_GUARD=0 rm -rf /dangerous/path
```

### Method 2: --no-guard Flag

Use the built-in bypass flag:

```bash
rm --no-guard -rf /dangerous/path
```

### Method 3: Disable in Session

Disable for the entire current shell session:

```bash
unset -f rm
export RM_GUARD=0
```

### Method 4: Use Absolute Path

Bypass the shell function entirely:

```bash
/bin/rm -rf /path
# or
command rm -rf /path
```

⚠️ **Warning**: Use these methods only if you know exactly what you're doing!

---

## Environment Variables

### `RM_GUARD`

Controls whether rmguard is active.

**Values:**
- `1` - Active (default)
- `0` - Disabled

**Usage:**
```bash
# Check current value
echo $RM_GUARD

# Disable temporarily
export RM_GUARD=0

# Re-enable
export RM_GUARD=1
```

### `ALLOW_TOPLEVEL`

Defines which top-level paths are allowed (set in config file).

**Default:**
```bash
ALLOW_TOPLEVEL="/tmp /var/tmp"
```

---

## Configuration File

**Location:** `/etc/rmguard.conf`

### Example Configuration

```bash
# Disable globally (not recommended)
# RM_GUARD=0

# Allowed top-level paths (default: /tmp and /var/tmp)
ALLOW_TOPLEVEL="/tmp /var/tmp"

# To allow additional paths (use with caution!):
# ALLOW_TOPLEVEL="/tmp /var/tmp /mnt/safe-mount"
```

### Edit Configuration

```bash
sudo nano /etc/rmguard.conf
```

### Reload Configuration

```bash
# Option 1: Restart shell
exit
# Then log back in

# Option 2: Source profile
source /etc/profile

# Option 3: Open new terminal
```

---

## Installation Commands

### Install

```bash
# From .deb
sudo apt install ./rmguard_0.0.1_all.deb

# From source
sudo ./scripts/install.sh
```

### Activate

```bash
source /etc/profile
```

### Verify

```bash
rmguard --status
type rm
```

### Uninstall

```bash
# If installed from source
cd rmguard/scripts
sudo ./uninstall.sh

# If installed from .deb
sudo apt remove rmguard
```

---

## Testing Commands

### Quick Tests

```bash
# Should be blocked
rm -rf /etc || echo "✅ Correctly blocked"

# Should work
touch /tmp/test && rm /tmp/test && echo "✅ /tmp works"
```

### Automated Tests

```bash
cd rmguard
sudo bash ./test/rmguard_test.sh
```

---

## Summary Table

| Command | Shortcut | Purpose |
|---------|----------|---------|
| `rmguard --help` | `-h` | Show help |
| `rmguard --version` | `-v` | Show version |
| `rmguard --status` | `-s` | Check status |
| `rmguard --check-updates` | `-c` | Update check |
| `RM_GUARD=0 rm ...` | - | Bypass for one command |
| `rm --no-guard ...` | - | Bypass with flag |
| `source /etc/profile` | - | Activate rmguard |
| `type rm` | - | Check if active |

---

## Additional Resources

- 📖 [Main Documentation](../README.md)
- 🇪🇸 [Spanish Documentation](../README.es.md)
- 🐛 [Report Issues](https://github.com/Happyuky7/RMGUARD-Linux/issues)
- 💡 [Request Features](https://github.com/Happyuky7/RMGUARD-Linux/issues/new)

---

**Last Updated**: May 24, 2026  
**Version**: 0.0.1
