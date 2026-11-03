# 安装指南

本指南说明如何下载并安装跨平台版 SVL（Avalonia / .NET 10）。

> **版本说明（2026-11-04 核对 API）**  
> - GitHub **Latest**（非预发布）仍为旧 WPF 线 `v1.1.8.6`。  
> - 跨平台 Avalonia 包在 **Pre-release** `v1.2.0.0`（标题「新架构预览版」）。下载时选该标签，勿把旧版 `SVL.Desktop_v1.1.x_*.exe` 当主安装方式。  
> - Gitee 镜像 `mc_shengxia/SVL-StardewValleyLauncher` 已发布同标签 `v1.2.0.0`（含 Linux/macOS/Windows 与 DEB 等资源）。  
> 来源：GitHub / Gitee Releases API、启动器仓库 `README.md`。

## 目录

- [系统要求](#系统要求)
- [包体类型](#包体类型)
- [推荐下载（v1.2.0.0 矩阵）](#推荐下载v1200-矩阵)
- [安装步骤](#安装步骤)
- [校验 SHA256](#校验-sha256)
- [旧版 EXE / 更新器兼容](#旧版-exe--更新器兼容)
- [常见问题](#常见问题)

## 系统要求

| 项目 | 要求 |
|------|------|
| 操作系统 | Windows 10/11；Linux x64（建议 XDG 桌面环境）；macOS 14+ |
| 运行时 | **自包含包**：无需本机安装 .NET；**轻量包**（文件名含 `requires_dotnet10`）：需对应架构的 [.NET 10 Runtime](https://dotnet.microsoft.com/download/dotnet/10.0) |
| 游戏 | Stardew Valley（Steam / GOG 等；路径可由启动器检测或手动指定） |
| 磁盘 | 启动器约数十到上百 MB（自包含更大）+ 游戏与 Mod 空间 |

> 旧文档中的 Windows 7 / .NET Framework 4.8 **不再适用于** Avalonia 主线。

## 包体类型

| 类型 | 识别方式 | 说明 |
|------|----------|------|
| 自包含（推荐不确定时选这个） | 文件名**不含** `requires_dotnet10` | 自带运行时，体积更大 |
| 轻量 | 文件名含 `requires_dotnet10` | 体积小；目标机需已装同架构 .NET 10 Runtime；**不能**当作旧版更新器的直接更新文件 |
| Release / Debug | 资源名含 `release` / `debug`，或 DEB 的 `debug` 段 | Debug 便于排障；日常请用 Release |

发布页还会附带 `SHA256SUMS.txt`、`update.txt` 等辅助文件。

## 推荐下载（v1.2.0.0 矩阵）

以 [v1.2.0.0](https://github.com/panda-lsy/SVL-StardewValleyLauncher/releases/tag/v1.2.0.0) 为例（Pre-release）。日常优先 **Release + 自包含**。

### Windows x64

| 场景 | 资源名示例 | 用法 |
|------|------------|------|
| 日常（自包含） | `SVL_v1.2.0.0_release_Windows_x64.zip` | 解压后运行 `SVL.Avalonia.exe` |
| 轻量 | `SVL_v1.2.0.0_release_Windows_x64_requires_dotnet10.zip` | 先装 .NET 10 Runtime，再解压运行 |
| Debug | `SVL_v1.2.0.0_debug_Windows_x64_requires_dotnet10.zip` 等 | 排障用；以发布页实际资源为准 |

### Linux x64

| 场景 | 资源名示例 | 用法 |
|------|------------|------|
| DEB 自包含 | `svl-launcher_1.2.0.0_amd64.deb` | `sudo apt install ./svl-launcher_1.2.0.0_amd64.deb`，或用图形安装器；之后可从应用菜单启动 |
| DEB 轻量 | `svl-launcher_1.2.0.0_amd64_requires_dotnet10.deb` | 需软件源提供 `dotnet-runtime-10.0`（与自包含 DEB **同名包**，装其一即可） |
| ZIP 免安装 | `SVL_v1.2.0.0_release_Linux_x64.zip` | 解压后执行 `sh run-svl.sh` |
| ZIP 轻量 | `SVL_v1.2.0.0_release_Linux_x64_requires_dotnet10.zip` | 同上，且需本机 .NET 10 Runtime |

发布页上可能还有无扩展名的同名产物（CI 工件形态）；**用户安装请优先 ZIP / DEB**。

### macOS

| 场景 | 资源名示例 | 用法 |
|------|------------|------|
| Apple 芯片自包含 | `SVL_v1.2.0.0_release_macOS_arm64.dmg` | 打开 DMG，拖入 Applications |
| Intel 自包含 | `SVL_v1.2.0.0_release_macOS_x64.dmg` | 同上 |
| 轻量 | 文件名含 `requires_dotnet10` 的对应 DMG | 需先装对应架构 .NET 10 Runtime |

> 正式分发签名 / 公证：启动器 README / 发布稿写明当前为 **临时 ad-hoc 签名**，正式分发仍需 Developer ID + Apple 公证。预发布说明：「首次打开可能需要在系统设置中允许」；Apple Silicon 上跑 Intel SteamCMD 需 **Rosetta 2**。系统「隐私与安全性」具体按钮文案因 macOS 版本而异，以本机提示为准。来源：启动器 `README.md`、`docs/release/v1.2.0.0-预发布草稿.md`。

### 下载源

| 源 | 地址 |
|----|------|
| GitHub（主） | [Releases](https://github.com/panda-lsy/SVL-StardewValleyLauncher/releases) |
| Gitee（镜像，**已同步** `v1.2.0.0` 资源，与 GitHub 同批约 31 个附件） | [Releases](https://gitee.com/mc_shengxia/SVL-StardewValleyLauncher/releases/tag/v1.2.0.0) |

## 安装步骤

### Windows

1. 下载对应 ZIP（优先 `release_Windows_x64.zip`）。
2. 解压到任意目录（勿只保留嵌套损坏的半包）。
3. 运行 `SVL.Avalonia.exe`。
4. 可选：为该 EXE 创建快捷方式。

### Linux（DEB）

```bash
sudo apt install ./svl-launcher_1.2.0.0_amd64.deb
```

安装后从应用菜单启动 SVL。

### Linux（ZIP）

```bash
unzip SVL_v1.2.0.0_release_Linux_x64.zip -d svl
cd svl
sh run-svl.sh
```

`run-svl.sh` 会处理可执行权限并转发参数。来源：启动器 `README.md`。

### macOS

1. 打开对应架构的 `.dmg`。
2. 将 `Stardew Valley Launcher.app` 拖到 Applications。
3. 从启动台 / Applications 打开。

### 配置与数据目录（参考）

新版用户数据目录基于 `Environment.SpecialFolder.LocalApplicationData` 下的 `SVL/Avalonia/`（例如 `settings.json`、日志等）。常见对应关系：

| 系统 | 典型路径 |
|------|----------|
| Windows | `%LOCALAPPDATA%\SVL\Avalonia\` |
| Linux | `~/.local/share/SVL/Avalonia/`（若设置了 `XDG_DATA_HOME` 则相对该目录） |
| macOS | `~/Library/Application Support/SVL/Avalonia/` |

来源：`SVL.Avalonia/Services/AppUserSettingsStore.cs`、`App.axaml.cs`。若本机路径不同，以实际文件夹为准。

首次启动会尝试迁移旧版配置与实例列表；旧文件保留，游戏本体与 Mod 不会因迁移被移动。来源：启动器 `README.md`。

### NXM 协议

SVL 支持关联 `nxm://`，以便从 NexusMods 一键下载。实现见 `NxmProtocolRegistrationService`（Windows HKCU、`LinuxNxmProtocolRegistration` 写 `svl-avalonia-nxm.desktop` + mimeapps、macOS 专用路径）。

Avalonia **没有**旧 WPF 式「首次启动是否关联」弹窗。改为：

1. 设置项 **「启动时尝试注册 NXM 协议」**（默认随 `RegisterNxmProtocolOnStartup`；启动时静默 `TryRegister`，失败不阻塞）。
2. 设置 → **下载设置** → NXM 卡片可看状态，并点 **「重新注册 NXM 协议」**。

Linux 处理器桌面文件 ID：`svl-avalonia-nxm.desktop`（`x-scheme-handler/nxm`）。

<p align="center">
  <a href="nxm://test/link">
    <img src="https://img.shields.io/badge/🧪_测试_NXM_协议-Click_Here-blue?style=for-the-badge" alt="测试 NXM 协议">
  </a>
</p>

> 测试链接仅验证协议是否被接管，不会下载真实 Mod。

## 校验 SHA256

发布页提供 `SHA256SUMS.txt`。下载后建议核对：

```bash
# Linux / macOS 示例
sha256sum -c SHA256SUMS.txt
# 或只核你下载的那一个文件名
```

```powershell
# Windows PowerShell 示例
Get-FileHash .\SVL_v1.2.0.0_release_Windows_x64.zip -Algorithm SHA256
# 与 SHA256SUMS.txt 中对应行比对
```

## 旧版 EXE / 更新器兼容

下列资源**不是**新用户的主安装路径：

| 资源 | 用途 |
|------|------|
| `SVL.Desktop_v{版本}_Release.exe` / `_Debug.exe` | 自包含构建额外产出的**单文件 EXE**。旧版更新器要求发布资产是真正的单文件 EXE，不能把 ZIP 改名为 EXE。需要给旧版在线更新用时，仍须把该 EXE 挂到 Release 资产上。 |
| `SVL_v{版本}_Windows_x64_requires_dotnet10.exe` / `_diagnostic.exe` | 轻量 / 诊断向单文件；**日常新装优先 ZIP/DEB/DMG**，勿与自包含 Desktop EXE 混淆 |
| 无扩展名的 `SVL_v*_Linux_x64`（及 debug 变体） | 与 ZIP 并列的可执行文件资产；Linux 也可直接下载后 `chmod +x` 运行 |
| 名称含 `requires_dotnet10` 的轻量包 | **不能**作为旧版的直接更新文件。 |

新版会识别当前包体类型，检查更新时只选**同类型**安装包；Windows 支持应用内替换，macOS / Linux 当前需到发布页手动安装。无法识别或没有同类型文件时，会提示手动选择，不会自动换类型。来源：启动器 `README.md`。


## 配置与日志目录

Avalonia 用户数据目录（`LocalApplicationData/SVL/Avalonia/`）：

| 平台 | 路径 |
|------|------|
| Windows | `%LocalAppData%\SVL\Avalonia\` |
| Linux | `~/.local/share/SVL/Avalonia/` |
| macOS | `~/Library/Application Support/SVL/Avalonia/` |

常见文件：`settings.json`、`instances-registry.json`、`instance-launch-settings.json`。详见 [设置与配置](../features/Settings)。

## 常见问题

### Q: 轻量包打不开 / 提示缺运行时

**A:** 安装与系统架构一致的 [.NET 10 Runtime](https://dotnet.microsoft.com/download/dotnet/10.0)，或改下自包含包。

### Q: 我只看到 `SVL.Desktop_….exe`，没有 ZIP/DMG/DEB？

**A:** 确认打开的是 Avalonia 预发布标签（如 `v1.2.0.0`），而不是仅含旧 WPF 资产的 Latest。新用户请用 ZIP / DEB / DMG。

### Q: 如何更新？

**A:**

1. 应用内检查更新（同包体类型）。
2. 或手动下载同类型新包覆盖 / 重装（macOS、Linux 当前更偏手动）。
3. 从旧 WPF 升到 Avalonia：首次启动会迁移配置；更新通道与 EXE 兼容说明见上一节。

### Q: macOS 提示无法打开未验证的开发者？

**A:** 与 ad-hoc 签名、未公证有关。按系统「隐私与安全性」提示允许打开，或等待正式 Developer ID / 公证包。发布说明亦提示首次打开可能需在系统设置中允许（见上文 macOS 节）。

---

## 下一步

- [初次使用指南](./Getting-Started)
- [创建游戏实例](./Creating-Instance)
- [安装 Mod](./Installing-Mods)
