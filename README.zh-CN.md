# RMGuard

简体中文 | [Español](README.es.md) | [Portugues](README.pt-BR.md) | [Francais](README.fr.md) | [English](README.md)

**RMGuard** 可以防止危险的 `rm` 命令（例如 `rm -f /*` 或 `rm -rf /etc`），而不会破坏系统脚本。
它仅在交互式 shell 中加载（例如，当用户通过 SSH/TTY 操作时），并允许在真正需要时显式强制执行。

网站和文档：[GitHub Pages](docs/index.html) | [FAQ](docs/FAQ.md) | [命令参考](docs/COMMANDS.md)

作者：[happyuky7.github.io](https://happyuky7.github.io/) | Sponsor：[GitHub Sponsors](https://github.com/sponsors/Happyuky7)

## 🔒 特性

- ✅ **阻止删除** `"/"` 和顶级路径（`/bin`、`/etc`、`/var` 等）。
- ✅ **默认允许** `/tmp` 和 `/var/tmp`（可配置）。
- ✅ **不替换** `/bin/rm`：定义一个调用 `/usr/lib/rmguard/rmguard` 的 `rm` 函数。
- ✅ **强制执行**：`RM_GUARD=0 rm …` 或 `rm --no-guard …`。

⚠️ **注意**：如果脚本使用绝对路径调用 `/bin/rm` 或使用 `command rm`，则不会通过 rmguard。建议：在您的脚本中使用不带路径的 `rm`。

---

## 📋 目录

- [安装](#安装)
- [快速开始](docs/GETTING_STARTED.md)
- [FAQ](docs/FAQ.md)
- [使用](#使用)
- [命令](#命令)
- [配置](#配置)
- [测试](#测试)
- [卸载](#卸载)
- [设计和决策](#设计和决策)
- [故障排除](#故障排除)
- [项目结构](#项目结构)
- [许可证](#许可证)

---

## 🚀 安装

**⚠️ 重要**：安装后，RMGuard 将在所有新的交互式会话（SSH、终端）中**自动激活**。安装后只需运行一次 `source /etc/profile` 即可在当前会话中激活它。

### 方法 1：手动安装（git clone）

```bash
git clone -b v1.0.0 https://github.com/Happyuky7/RMGUARD-Linux.git
cd RMGUARD-Linux
chmod +x scripts/*.sh src/rmguard src/rmguard-cli test/rmguard_test.sh
sudo bash ./scripts/install.sh
# 在当前会话中激活或打开新会话：
source /etc/profile
```

### 方法 2：从 .deb 包安装

如果 release 附带 `.deb` 包，请从 [Releases](https://github.com/Happyuky7/RMGUARD-Linux/releases) 下载并安装：

```bash
# 下载最新版本
wget https://github.com/Happyuky7/RMGUARD-Linux/releases/latest/download/rmguard_1.0.0_all.deb

# 安装
sudo apt install ./rmguard_1.0.0_all.deb

# 在当前会话中激活（仅一次）
source /etc/profile
```

### ✅ 验证安装

```bash
# 验证 RMGuard 是否激活
rmguard --status

# 或手动验证
type rm
# 可能先显示 rmguard alias；rmguard --status 应报告 ACTIVE。
```

---

## 💻 使用

和平常一样：

```bash
rm -rf folder
```

如果您尝试危险操作：

```bash
rm -f /*         # → 被阻止
rm -rf /etc      # → 被阻止
```

强制执行（仅当您知道自己在做什么时）：

```bash
RM_GUARD=0 rm -rf /etc
# 或：
rm --no-guard -rf /etc
```

---

## 🛠️ 命令

### 显示帮助

```bash
rmguard --help
# 或
rmguard -h
```

### 显示版本

```bash
rmguard --version
# 或
rmguard -v
```

### 检查 rmguard 状态

```bash
rmguard --status
# 或
rmguard -s
```

### 检查更新

```bash
rmguard --check-updates
# 或
rmguard -c

# 如果有可用更新，将询问您是否要安装
```

### 完整命令列表

| 命令 | 别名 | 描述 |
|------|------|------|
| `rmguard --help` | `-h` | 显示完整帮助菜单 |
| `rmguard --version` | `-v` | 显示已安装版本 |
| `rmguard --status` | `-s` | 检查 rmguard 是否激活 |
| `rmguard --check-updates` | `-c` | 检查更新并允许安装 |

### 临时禁用 rmguard

```bash
# 选项 1：仅对特定命令
RM_GUARD=0 rm -rf /dangerous/path

# 选项 2：使用 --no-guard 标志
rm --no-guard -rf /dangerous/path

# 选项 3：在当前会话中禁用
unset -f rm
export RM_GUARD=0
```

---

## ⚙️ 配置

**文件**：`/etc/rmguard.conf`

```bash
# 全局禁用（不推荐）
# RM_GUARD=0

# 允许的顶级路径（默认 /tmp 和 /var/tmp）
ALLOW_TOPLEVEL="/tmp /var/tmp"
```

---

## 🧪 测试

```bash
# 阻止顶级路径
rm -rf /etc || echo "OK: 已阻止 /etc"

# 允许 /tmp
touch /tmp/x && rm -f /tmp/x && echo "OK: /tmp 已允许"

# 自动化测试：
sudo bash ./test/rmguard_test.sh
```

---

## 🗑️ 卸载

```bash
cd RMGUARD-Linux
sudo bash ./scripts/uninstall.sh
```

---

## 🏗️ 设计和决策

1. **仅交互式 shell**：通过 `/etc/profile.d` 加载，避免破坏系统服务或脚本。
2. **不触碰或替换 `/bin/rm`**：公开一个调用 `/usr/lib/rmguard/rmguard` 的 `rm()` 函数。
3. **默认安全阻止**：防止 `"/"` 和顶级路径（例如 `/bin`、`/etc`、`/var`），除了可配置的白名单（`/tmp`、`/var/tmp`）。
4. **可显式强制**：当您需要执行特殊和有意识的操作时使用 `RM_GUARD=0` 或 `--no-guard`。
5. **友好的别名**：`-I` 和 `--preserve-root=all` 添加积极的摩擦；它们不替代保护规则。
6. **持久性**：安装后，每次新会话都会自动激活，无需额外配置。

---

## 🔄 自动运行

### ✅ rmguard 自动激活于：
- 打开的新终端
- SSH 会话
- 交互式 bash shell
- 系统重启后

### ❌ rmguard 不激活于：
- 系统脚本（以免破坏服务）
- Cron 作业
- Systemd 服务
- 使用绝对路径 `/bin/rm` 的脚本

### 📋 检查是否激活

```bash
# 方法 1：使用状态命令
rmguard --status

# 方法 2：手动检查
type rm
# 可能先显示 rmguard alias；rmguard --status 应报告 ACTIVE。

# 方法 3：查看环境变量
echo $RM_GUARD
# 预期输出：1（激活）或空/0（未激活）
```

---

## 🔧 故障排除

### "我的脚本没有通过 rmguard"
如果使用 `/bin/rm`（绝对路径）或 `command rm`，它会绕过 shell 函数。**建议**：在您自己的脚本中使用不带路径的 `rm`。

### "安装后 rmguard 未激活"
打开新会话或运行 `source /etc/profile`。使用以下命令验证：

```bash
type rm   # 可能先显示 rmguard alias
```

### "我需要允许另一个顶级路径"
编辑 `/etc/rmguard.conf` 并添加到 `ALLOW_TOPLEVEL`（⚠️ 小心）。

### "如何临时禁用 rmguard？"
参见命令部分的[临时禁用 rmguard](#临时禁用-rmguard)。

### "重启后 rmguard 会激活吗？"
是的，安装后 rmguard 会在每次新会话中自动激活。您不需要重新配置它。

---

## 📁 项目结构

```
rmguard/
├─ src/
│  └─ rmguard                 # 主二进制文件（包装器）
├─ etc/
│  └─ profile.d/
│     └─ rmguard.sh           # 在交互式 shell 中激活 rmguard
├─ config/
│  └─ rmguard.conf            # 可选配置（白名单顶级路径）
├─ scripts/
│  ├─ install.sh              # 手动安装（git clone）
│  ├─ uninstall.sh            # 手动卸载
│  └─ package.sh              # 生成 rmguard_1.0.0_all.deb
├─ test/
│  └─ rmguard_test.sh         # 快速测试
├─ README.md                  # 英文文档
├─ README.es.md               # 西班牙文文档
├─ README.pt-BR.md            # 巴西葡萄牙文文档
├─ README.fr.md               # 法文文档
├─ README.zh-CN.md            # 简体中文文档
└─ LICENSE
```

---

## 📄 许可证

**MIT 许可证** — 详见 [LICENSE](LICENSE) 文件。

---

## 🤝 贡献

欢迎贡献！请：

1. Fork 项目
2. 为您的功能创建分支（`git checkout -b feature/AmazingFeature`）
3. 提交您的更改（`git commit -m 'Add some AmazingFeature'`）
4. 推送到分支（`git push origin feature/AmazingFeature`）
5. 打开 Pull Request

---

## 📦 构建 .deb 包

如果您想自己构建 `.deb` 包：

```bash
bash ./scripts/package.sh 1.0.0

# 包将创建在：
# build/rmguard_1.0.0_all.deb
```

创建发布版本：

```bash
bash ./scripts/release.sh 1.0.0
```

---

## 🔮 未来实现

- 🚧 **APT 仓库**：在官方仓库中发布以便更轻松安装
- 🚧 **通过 APT 自动更新**：系统自动更新

---

## ⚠️ 警告

此软件是一个额外的保护层，但**并非万无一失**。在生产系统上运行破坏性命令时始终要小心。

---

**由 [Happyuky7](https://github.com/Happyuky7) 用 ❤️ 开发，用于保护您的 Linux 系统**
