# 构建项目

从源码构建 **Avalonia** 版 SVL。步骤对齐启动器仓库根目录 `README.md` 与 `build.ps1`。

## 目录

- [环境要求](#环境要求)
- [获取源码](#获取源码)
- [本地构建与运行](#本地构建与运行)
- [打包发布（build.ps1）](#打包发布buildps1)
- [产物与注意事项](#产物与注意事项)
- [常见问题](#常见问题)

## 环境要求

| 软件 | 说明 |
|------|------|
| **.NET 10 SDK** | 必需；[下载](https://dotnet.microsoft.com/download/dotnet/10.0) |
| **Git** | 克隆仓库 |
| **PowerShell** | 跑 `build.ps1`（Windows 自带；Linux/macOS 可用 `pwsh`） |
| **可选 IDE** | Visual Studio 2022 / Rider / VS Code + C# 扩展 |

额外工具（按目标）：

| 目标 | 额外要求 |
|------|----------|
| Linux DEB | 构建机有 `dpkg-deb` 时才会打出 `.deb` |
| macOS DMG | **在 macOS 上**跑 macos 目标；布局文件见 `packaging/macos/` |

旧文档中的「.NET Framework 4.8 / 仅 MSBuild WPF」**已不适用**于主线。

## 获取源码

```bash
git clone --branch main --single-branch https://github.com/panda-lsy/SVL-StardewValleyLauncher.git
cd SVL-StardewValleyLauncher
```

默认开发分支为 `main`（Avalonia）。需要对照旧 UI 时再看仓库内 `SVL.Desktop` / 历史分支，不要当作默认启动项目。

## 本地构建与运行

```bash
# Debug
dotnet build SVL.Avalonia/SVL.Avalonia.csproj --configuration Debug

# Release
dotnet build SVL.Avalonia/SVL.Avalonia.csproj --configuration Release

# 运行
dotnet run --project SVL.Avalonia/SVL.Avalonia.csproj
```

也可打开 `SVL.sln`，将 **SVL.Avalonia** 设为启动项目后调试。

测试（迁移测试项目）：

```bash
dotnet test SVL.Migration.Tests/SVL.Migration.Tests.csproj
```

## 打包发布（build.ps1）

根目录统一脚本，支持 Windows / Linux / macOS，以及 Debug / Release；加 `-FrameworkDependent` 打轻量包（文件名带 `requires_dotnet10`）。

```powershell
# Windows x64 Debug 单文件相关产物
.\build.ps1 -Config Debug -Targets windows

# Windows x64 Release（自包含）
.\build.ps1 -Config Release -Targets windows

# 轻量（目标机需预装对应架构 .NET 10 Runtime）
.\build.ps1 -Config Release -Targets windows -FrameworkDependent
.\build.ps1 -Config Release -Targets linux -FrameworkDependent
.\build.ps1 -Config Release -Targets macos -FrameworkDependent

# Linux x64
.\build.ps1 -Config Release -Targets linux

# 仅 macOS（建议在 macOS 上执行以生成 .dmg）
.\build.ps1 -Config Release -Targets macos

# 全部目标双配置（耗时长）
.\build.ps1 -Config all -Targets all
```

CI 参考：`.github/workflows/package-avalonia.yml`。

Linux 也可对已有 ZIP 单独打 DEB：

```bash
sh scripts/package-linux-deb.sh <Linux ZIP> <输出目录> 1.2.0.0
# 轻量 ZIP 末尾再加 framework-dependent；输出目录勿已有同名包
```

来源：启动器 `README.md`。

## 产物与注意事项

- 默认输出目录：`artifacts/`（可用 `-OutputDirectory` 覆盖）。
- 命名大致：`SVL_v{版本}_{config}_{platform}_{arch}.{ext}`；DEB 为 `svl-launcher_*_amd64.deb`。
- **自包含**还可能生成 `SVL.Desktop_v{版本}_{Debug|Release}.exe`：给**旧版更新器**用的单文件 EXE，不是新用户主安装包。详见 [安装指南](../tutorials/Installation#旧版-exe--更新器兼容)。
- 轻量包**不能**当作旧版直接更新文件。
- macOS：DMG 含 app 与 Applications 链接；当前多为临时 ad-hoc 签名，正式分发需 Developer ID + 公证。
- SteamCMD：按系统拉官方包；Apple 芯片上官方 macOS SteamCMD 启动包为 Intel，可能需要 Rosetta 2。来源：`README.md`。

## 常见问题

### Q: 提示找不到 net10.0 / SDK

**A:** 安装 .NET 10 SDK，执行 `dotnet --list-sdks` 确认。

### Q: 还在构建 SVL.Desktop？

**A:** 改用 `SVL.Avalonia` 项目或当前 `SVL.sln`。旧 WPF 项目不在新版默认发布路径。

### Q: Linux 没有生成 .deb？

**A:** 需要环境里有 `dpkg-deb`；或用 `scripts/package-linux-deb.sh` 对 ZIP 后处理。

### Q: NuGet 还原失败

**A:** 检查网络与 `nuget.org` 源；必要时 `dotnet restore SVL.Avalonia/SVL.Avalonia.csproj`。

---

## 相关文档

- [项目结构](./Project-Structure)
- [技术栈](./Tech-Stack)
- [贡献指南](../community/Contributing)
