<p align="center">
  <img src="images/icon.png" alt="SVL Logo" width="128" height="128">
</p>

<h1 align="center">SVL Wiki</h1>

<p align="center">
  <b>Stardew Valley Launcher · 星露谷物语启动器文档</b>
</p>

---

## 关于 SVL

**SVL (Stardew Valley Launcher)** 是星露谷物语启动器与 Mod 管理器。主线基于 **Avalonia UI + .NET 10**，支持 **Windows / Linux / macOS**。可管理游戏实例、安装与组织 Mod、对接 NexusMods / CurseForge，以及创建和分享 Modpack。

> 产品站与部分页面可能仍写「仅 Windows」；以本 Wiki 修订页与 [启动器仓库 README](https://github.com/panda-lsy/SVL-StardewValleyLauncher) 为准。

## 核心功能

| 功能 | 描述 |
|------|------|
| 游戏启动 | 多实例、SMAPI 安装与版本隔离 |
| Mod 管理 | 启用/禁用、更新检测、依赖与冲突 |
| NexusMods / CurseForge | 搜索、登录、下载；Nexus 支持 `nxm://` |
| Modpack | 创建/导入；兼容多种整合包格式 |
| 下载管理 | 多任务队列与进度 |
| 主题 | 深色/浅色等（Fluent 主题体系） |

## 文档开发进度

> 未标注「已按 Avalonia 修订」的页面，内容可能仍残留 WPF / Win7 表述。**一切以启动器实机与源码为准。**  
> 新截图目录：`docs/tutorials/image/avalonia/`（标注 Linux · v1.2.0.0）。

| 章节 | 进度 | 状态 | 最后更新 |
|------|------|------|----------|
| **快速开始** | | | |
| ├─[安装指南](./docs/tutorials/Installation) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ Gitee v1.2.0.0 已同步；匿名统计 FAQ | 2026-11-04 |
| ├─[初次使用](./docs/tutorials/Getting-Started) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 已对齐导航文案；配 Avalonia 截图 | 2026-11-04 |
| ├─[创建游戏实例](./docs/tutorials/Creating-Instance) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 对齐 versions 流程；去掉隔离开关 | 2026-11-04 |
| └─[安装 Mods](./docs/tutorials/Installing-Mods) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 下载·Mod 截图；实例 Mod 管理页未拍到 | 2026-11-04 |
| **功能文档** | | | |
| ├─[游戏实例管理](./docs/features/Instance-Management) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 版本选择 + 版本设置侧栏 | 2026-11-04 |
| ├─[Mod 管理](./docs/features/Mod-Management) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 工具栏/筛选/备份分栏对齐源码 | 2026-11-04 |
| ├─[NexusMods 集成](./docs/features/NexusMods-Integration) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 登录改下载设置；NXM/任务页 | 2026-11-04 |
| ├─[Modpack 整合包](./docs/features/Modpack-Support) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 导入/导出；不含本体 | 2026-11-04 |
| ├─[下载管理器](./docs/features/Download-Manager) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 任务页文案 + SteamCMD 游戏本体 | 2026-11-04 |
| └─[主题与外观](./docs/features/Theming) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 个性化页对齐 ThemeService | 2026-11-04 |
| **高级功能** | | | |
| ├─[版本隔离](./docs/features/Version-Isolation) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 存档共享；1.1.8.2 无开关 | 2026-11-04 |
| ├─[SMAPI 管理](./docs/features/SMAPI-Management) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 下载/拖放/自动安装对齐 | 2026-11-04 |
| └─[设置与配置](./docs/features/Settings) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 关于更新控件 + 匿名统计（仅环境变量关闭） | 2026-11-04 |
| **开发文档** | | | |
| ├─[项目结构](./docs/development/Project-Structure) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 已按 Avalonia 仓库结构重写 | 2026-11-03 |
| ├─[技术栈](./docs/development/Tech-Stack) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 已按 Avalonia/.NET 10 重写 | 2026-11-03 |
| └─[构建指南](./docs/development/Building) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 已对齐 `build.ps1` / `SVL.Avalonia` | 2026-11-03 |
| **贡献指南** | | | |
| ├─[对 Wiki 进行贡献](./docs/community/Contributing) | ![100%](https://img.shields.io/badge/进度-100%25-brightgreen) | ✅ 完成 | 2026-03 |
| └─[社区资源本地化](./docs/community/Localization-Contributing) | ![已修订](https://img.shields.io/badge/进度-Avalonia_修订-brightgreen) | ✅ 贡献 URL / 启动器入口 / 汉化源对齐 | 2026-11-04 |

> **说明**：不要把「未校对的旧稿」标成 100%。本表只反映文档状态，不代表启动器功能完成度。

## 文档导航

### 快速开始

- [安装指南](./docs/tutorials/Installation) - 下载和安装 SVL（Win / Linux / macOS）
- [初次使用](./docs/tutorials/Getting-Started) - 第一次使用 SVL
- [创建游戏实例](./docs/tutorials/Creating-Instance) - 创建和管理游戏实例
- [安装 Mods](./docs/tutorials/Installing-Mods) - 下载、拖放与本地安装

### 功能文档

- [游戏实例管理](./docs/features/Instance-Management)
- [Mod 管理](./docs/features/Mod-Management)
- [NexusMods 集成](./docs/features/NexusMods-Integration)
- [Modpack 整合包](./docs/features/Modpack-Support)
- [下载管理器](./docs/features/Download-Manager)
- [主题与外观](./docs/features/Theming)

### 高级功能

- [版本隔离](./docs/features/Version-Isolation)
- [SMAPI 管理](./docs/features/SMAPI-Management)
- [设置与配置](./docs/features/Settings)

### 开发文档

- [项目结构](./docs/development/Project-Structure)
- [技术栈](./docs/development/Tech-Stack)
- [构建指南](./docs/development/Building)

### 贡献指南

- [对 Wiki 进行贡献](./docs/community/Contributing)
- [社区资源本地化](./docs/community/Localization-Contributing)

## 为 Wiki 做出贡献

欢迎修错别字、补教程、报文档问题。

1. Fork 本仓库
2. 用 Markdown 编辑
3. 提交 Pull Request，写清改了什么

详见 [Wiki 贡献指南](./docs/community/Contributing)。

## 链接

- **源码**: [SVL-StardewValleyLauncher](https://github.com/panda-lsy/SVL-StardewValleyLauncher)
- **问题反馈**: [Issues](https://github.com/panda-lsy/SVL-StardewValleyLauncher/issues)
- **发布下载**: [Releases](https://github.com/panda-lsy/SVL-StardewValleyLauncher/releases)
- **赞助**: [爱发电](https://ifdian.net/a/mcshengxia)

## 系统要求

| 项目 | 要求 |
|------|------|
| 操作系统 | Windows 10/11、Linux x64、macOS 14+ |
| 运行时 | 自包含包无需本机 .NET；轻量包需 [.NET 10 Runtime](https://dotnet.microsoft.com/download/dotnet/10.0)（架构一致） |
| 从源码构建 | [.NET 10 SDK](https://dotnet.microsoft.com/download/dotnet/10.0) |
| 游戏 | Stardew Valley（Steam / GOG 等） |

详细安装见 [安装指南](./docs/tutorials/Installation)。

## 许可证

SVL 基于 [Apache License 2.0](https://github.com/panda-lsy/SVL-StardewValleyLauncher/blob/main/LICENSE) 开源。

---

<p align="center">
  <i>如果这个项目对你有帮助，请考虑给个 ⭐ Star 支持一下！</i>
</p>
