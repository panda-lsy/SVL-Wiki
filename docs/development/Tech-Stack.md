# 技术栈

本文档对应 **Avalonia 主线**（`main` / `SVL.Avalonia`）。旧 WPF / .NET Framework 4.8 源码仍留在仓库中供对照，**不在**默认解决方案构建路径内。

版本号以仓库内 `.csproj` 为准；下文取自修订时的 `SVL.Avalonia.csproj` / `SVL.Core.Platform.csproj` / `SVL.Migration.Tests.csproj`。

## 目录

- [核心框架](#核心框架)
- [主要依赖](#主要依赖)
- [UI](#ui)
- [数据与配置](#数据与配置)
- [平台层](#平台层)
- [测试](#测试)
- [遗留代码](#遗留代码)

## 核心框架

| 技术 | 版本（修订时） | 用途 |
|------|----------------|------|
| **.NET** | 10（`net10.0`） | 运行时 / 目标框架 |
| **C#** | 随 SDK | 语言 |
| **Avalonia** | 11.2.8 | 跨平台 UI |
| **Avalonia.Desktop** | 11.2.8 | 桌面宿主 |
| **Avalonia.Themes.Fluent** | 11.2.8 | Fluent 主题 |

来源：`SVL.Avalonia/SVL.Avalonia.csproj`。

### 为什么是 Avalonia + .NET 10？

- 同一套 UI 跑 Windows / Linux / macOS
- 现代 BCL 与发布模型（自包含 / framework-dependent）
- 与启动器 README 及 `package-avalonia.yml` 发布流水线一致

## 主要依赖

| 包 | 版本（修订时） | 用途 |
|------|----------------|------|
| **CommunityToolkit.Mvvm** | 8.4.0 | MVVM（`ObservableObject`、`RelayCommand` 等） |
| **SharpZipLib** | 1.4.2 | ZIP 等压缩处理 |
| **SharpCompress** | 0.49.1 | 更多归档格式（Avalonia 与 Core.Platform 均引用） |
| **AnimatedImage.Avalonia** | 2.1.4 | 动图 |
| **Tmds.DBus.Protocol** | 0.21.3 | Linux 桌面相关（如协议/会话集成，**待核实**具体调用面） |

来源：`SVL.Avalonia/SVL.Avalonia.csproj`、`SVL.Core.Platform/SVL.Core.Platform.csproj`。

> **待核实**：是否仍使用 LiteDB / YamlDotNet / Newtonsoft.Json。旧 Wiki 按 WPF 列出；Avalonia 配置侧可见 `System.Text.Json`（如 `AppUserSettingsStore`）。请以各项目 `PackageReference` 与 `using` 为准，勿照搬下表旧假设。

## UI

| 技术 | 用途 |
|------|------|
| **AXAML** | 视图布局（`Views/`、`Controls/`） |
| **Fluent 主题** | 深色 / 浅色等 |
| **DynamicResource** | 主题配色（见启动器 README「界面与主题」） |
| **数据绑定 + MVVM** | View ↔ ViewModel |

资源与样式大致在 `SVL.Avalonia/Resources/`、`Assets/`。**待核实**主题文件树是否与旧 `Themes/*.xaml` 一一对应（旧结构已不适用）。

## 数据与配置

| 内容 | 说明 | 来源 |
|------|------|------|
| 用户设置 | `LocalApplicationData/SVL/Avalonia/settings.json`（`System.Text.Json`） | `AppUserSettingsStore.cs` |
| 实例注册等 | 同目录树下其它 JSON / 存储服务 | `InstanceRegistryStore.cs` 等 |
| 崩溃日志 | `.../SVL/Avalonia/logs/crash.log` | `App.axaml.cs` |

网络：`HttpClient` 类服务（下载、Nexus / CurseForge / 更新检查等）。OAuth、`nxm://` 仍存在；具体类名见 `SVL.Avalonia/Services/`、`SVL.Core.Platform/Services/`（如 `LinuxNxmProtocolRegistration.cs`）。

## 平台层

`SVL.Core.Platform`（`net10.0`）提供 Windows / Linux / macOS 差异实现，例如：

- 游戏安装路径探测（`GameInstallPathLocator.cs`）
- Linux NXM / XDG 相关注册
- 其它平台服务（回收站、协议等）

**待核实**：完整服务清单以该项目 `Services/` 目录为准。

## 测试

| 项目 | 框架 | 说明 |
|------|------|------|
| **SVL.Migration.Tests** | MSTest + Avalonia.Headless | 在默认 `SVL.sln` 中 |
| **SVL.Tests** | **待核实** | 仓库内存在；是否纳入默认 sln / CI 以当前 `SVL.sln` 与 workflow 为准 |

来源：`SVL.Migration.Tests/SVL.Migration.Tests.csproj`、`SVL.sln`。

## 遗留代码

| 路径 | 状态 |
|------|------|
| `SVL.Desktop/`、`SVL.Core/` | 旧 WPF / Core，暂留对照，**非**新版默认构建依赖 |
| `legacy-wpf` 等分支 | 历史线；日常开发看 `main` + Avalonia |

---

## NuGet 快照（修订时）

```xml
<!-- SVL.Avalonia.csproj 摘录 -->
<PackageReference Include="AnimatedImage.Avalonia" Version="2.1.4" />
<PackageReference Include="Avalonia" Version="11.2.8" />
<PackageReference Include="Avalonia.Desktop" Version="11.2.8" />
<PackageReference Include="Avalonia.Themes.Fluent" Version="11.2.8" />
<PackageReference Include="CommunityToolkit.Mvvm" Version="8.4.0" />
<PackageReference Include="SharpCompress" Version="0.49.1" />
<PackageReference Include="SharpZipLib" Version="1.4.2" />
<PackageReference Include="Tmds.DBus.Protocol" Version="0.21.3" />
```

升级后请以仓库文件为准更新本页。

---

## 相关文档

- [项目结构](./Project-Structure)
- [构建项目](./Building)
- [贡献指南](../community/Contributing)
