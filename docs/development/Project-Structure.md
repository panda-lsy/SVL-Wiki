# 项目结构

本文档介绍 SVL-StardewValleyLauncher 的项目结构。

## 📋 目录

- [整体架构](#整体架构)
- [项目组成](#项目组成)
- [核心目录结构](#核心目录结构)
- [模块划分](#模块划分)

## 整体架构

SVL 采用 MVVM 架构模式，基于 .NET Framework 4.8 和 WPF 构建。

```
┌─────────────────────────────────────────────────────────┐
│                      UI Layer (WPF)                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Views     │  │  Controls   │  │  Converters │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
├─────────────────────────────────────────────────────────┤
│                    ViewModel Layer                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │ MainVM      │  │ InstanceVM  │  │  ModVM      │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
├─────────────────────────────────────────────────────────┤
│                    Service Layer                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │ NexusService│  │ModService   │  │DownloadSvc  │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
├─────────────────────────────────────────────────────────┤
│                     Data Layer                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Models    │  │  Repository │  │   LiteDB    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
```

## 项目组成

| 项目 | 说明 | 输出类型 |
|------|------|----------|
| **SVL.Desktop** | 桌面应用程序主项目 | WPF 应用程序 |
| **SVL.Core** | 核心业务逻辑 | 类库 |
| **SVL.Infrastructure** | 基础设施层 | 类库 |

## 核心目录结构

```
SVL-StardewValleyLauncher/
├── src/
│   ├── SVL.Desktop/           # 桌面应用项目
│   │   ├── Views/             # XAML 视图
│   │   │   ├── MainWindow.xaml
│   │   │   ├── Pages/
│   │   │   │   ├── HomePage.xaml
│   │   │   │   ├── ModPage.xaml
│   │   │   │   ├── DownloadPage.xaml
│   │   │   │   └── SettingsPage.xaml
│   │   │   └── Dialogs/
│   │   ├── ViewModels/        # 视图模型
│   │   │   ├── MainViewModel.cs
│   │   │   ├── HomeViewModel.cs
│   │   │   └── ...
│   │   ├── Controls/          # 自定义控件
│   │   ├── Converters/        # 值转换器
│   │   ├── Themes/            # 主题资源
│   │   │   ├── Light.xaml
│   │   │   ├── Dark.xaml
│   │   │   └── Colors/
│   │   ├── Resources/         # 静态资源
│   │   │   ├── Images/
│   │   │   └── Icons/
│   │   ├── App.xaml           # 应用程序入口
│   │   └── App.xaml.cs
│   │
│   ├── SVL.Core/              # 核心业务层
│   │   ├── Models/            # 数据模型
│   │   │   ├── GameInstance.cs
│   │   │   ├── ModInfo.cs
│   │   │   ├── DownloadTask.cs
│   │   │   └── ...
│   │   ├── Services/          # 服务接口
│   │   │   ├── IInstanceService.cs
│   │   │   ├── IModService.cs
│   │   │   ├── IDownloadService.cs
│   │   │   └── INexusModsService.cs
│   │   ├── Events/            # 事件定义
│   │   └── Exceptions/        # 自定义异常
│   │
│   └── SVL.Infrastructure/    # 基础设施层
│       ├── Services/          # 服务实现
│       │   ├── InstanceService.cs
│       │   ├── ModService.cs
│       │   ├── DownloadService.cs
│       │   ├── NexusModsService.cs
│       │   └── SmapiService.cs
│       ├── Repositories/      # 数据仓库
│       ├── Configuration/     # 配置管理
│       ├── FileSystem/        # 文件系统操作
│       └── Networking/        # 网络请求
│
├── docs/                      # 文档
├── tests/                     # 测试项目
├── .github/                   # GitHub 配置
│   └── workflows/
├── Directory.Build.props
├── global.json
└── README.md
```

## 模块划分

### 实例管理模块

负责游戏实例的创建、管理和启动。

| 文件/类 | 功能 |
|---------|------|
| `GameInstance` | 实例数据模型 |
| `InstanceService` | 实例 CRUD 操作 |
| `InstanceManager` | 实例运行时管理 |
| `VersionIsolation` | 版本隔离处理 |

### Mod 管理模块

负责 Mod 的安装、启用、禁用和更新。

| 文件/类 | 功能 |
|---------|------|
| `ModInfo` | Mod 信息模型 |
| `ModService` | Mod 操作服务 |
| `DependencyResolver` | 依赖解析 |
| `ConflictDetector` | 冲突检测 |

### 下载管理模块

负责文件下载和任务管理。

| 文件/类 | 功能 |
|---------|------|
| `DownloadTask` | 下载任务模型 |
| `DownloadService` | 下载服务 |
| `HttpClientHandler` | HTTP 请求处理 |
| `DownloadQueue` | 下载队列管理 |

### NexusMods 集成模块

负责与 NexusMods API 交互。

| 文件/类 | 功能 |
|---------|------|
| `NexusModsService` | NexusMods 服务 |
| `OAuthClient` | OAuth 认证 |
| `NxProtocolHandler` | NXM 协议处理 |

### 主题系统模块

负责应用程序主题管理。

| 文件/类 | 功能 |
|---------|------|
| `ThemeService` | 主题切换服务 |
| `AccentColor` | 强调色配置 |
| `ResourceDictionary` | WPF 资源 |

---

## 相关文档

- [技术栈](./Tech-Stack)
- [构建项目](./Building)
- [贡献指南](../community/Contributing)
