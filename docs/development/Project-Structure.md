# 项目结构

对应仓库 [SVL-StardewValleyLauncher](https://github.com/panda-lsy/SVL-StardewValleyLauncher) 的 **Avalonia 主线**。目录以仓库根布局为准（**不是**旧文档里的 `src/SVL.Desktop` 三层假想结构）。

## 目录

- [整体架构](#整体架构)
- [解决方案项目](#解决方案项目)
- [仓库树](#仓库树)
- [模块提示](#模块提示)

## 整体架构

MVVM + 平台抽象：UI 在 Avalonia，系统差异在 `SVL.Core.Platform`。

```
┌─────────────────────────────────────────────────────────┐
│              UI (SVL.Avalonia · AXAML)                   │
│   Views / Controls / Resources / Assets                 │
├─────────────────────────────────────────────────────────┤
│              ViewModels (CommunityToolkit.Mvvm)         │
├─────────────────────────────────────────────────────────┤
│              App Services (SVL.Avalonia/Services)       │
├─────────────────────────────────────────────────────────┤
│         Platform (SVL.Core.Platform/Services)           │
│         Windows / Linux / macOS 实现                    │
└─────────────────────────────────────────────────────────┘
```

## 解决方案项目

`SVL.sln`（修订时）包含：

| 项目 | 说明 | 输出 |
|------|------|------|
| **SVL.Avalonia** | 跨平台桌面主程序 | 可执行应用 |
| **SVL.Core.Platform** | 平台抽象与实现 | 类库 |
| **SVL.Migration.Tests** | 迁移等相关测试 | 测试 |

**不在**默认 sln 构建路径、但仓库中仍存在：

| 路径 | 说明 |
|------|------|
| `SVL.Desktop/`、`SVL.Core/` | 旧 WPF / Core，迁移对照 |
| `SVL.Tests/` | **待核实**是否仍维护、是否进 CI |

来源：`SVL.sln`、启动器 `README.md`「项目结构」。

## 仓库树

```
SVL-StardewValleyLauncher/
├── SVL.Avalonia/              # Avalonia 主项目
│   ├── ViewModels/
│   ├── Views/                 # AXAML 页面
│   ├── Controls/
│   ├── Resources/             # 主题与样式
│   ├── Services/              # 应用服务
│   ├── Models/
│   ├── Converters/
│   ├── Assets/                # 图标等
│   ├── App.axaml / App.axaml.cs
│   └── SVL.Avalonia.csproj    # TargetFramework: net10.0
├── SVL.Core.Platform/         # 平台层
│   ├── Services/              # 如 GameInstallPathLocator、Linux NXM 等
│   └── SVL.Core.Platform.csproj
├── SVL.Migration.Tests/
├── SVL.Core/                  # 旧代码（参考）
├── SVL.Desktop/               # 旧 WPF UI（参考）
├── SVL.Tests/                 # 待核实
├── packaging/                 # 如 macOS DMG 布局
├── scripts/                   # 打包辅助（如 package-linux-deb.sh）
├── .github/workflows/         # 含 package-avalonia.yml
├── build.ps1                  # 统一多平台打包
├── docs/                      # 仓库内开发/发布文档
├── CHANGELOG.md
├── LICENSE
└── SVL.sln
```

用户数据（运行时，非仓库内）：`LocalApplicationData/SVL/Avalonia/`（见 [安装指南](../tutorials/Installation)）。

## 模块提示

下列名称便于检索源码，**不是**对外 API 承诺。类名以仓库为准；不确定处标了路径。

### 实例与路径

| 线索 | 路径提示 |
|------|----------|
| 实例页 VM | `SVL.Avalonia/ViewModels/InstancesPageViewModel.cs` |
| 实例注册存储 | `SVL.Avalonia/Services/InstanceRegistryStore.cs` |
| 游戏路径探测 | `SVL.Core.Platform/Services/GameInstallPathLocator.cs` |

### Mod / 下载 / 商店

| 线索 | 路径提示 |
|------|----------|
| 下载页 VM | `SVL.Avalonia/ViewModels/DownloadPageViewModel.cs` |
| 下载安装服务 | `SVL.Avalonia/Services/DownloadInstallService.cs`、`HttpDownloadService.cs` |
| Nexus / CurseForge 缓存等 | `SVL.Avalonia/Services/*DownloadCache*.cs` 等 |
| 功能页大 VM | `SVL.Avalonia/ViewModels/FeaturePagesViewModels.cs`（**待核实**拆分情况） |

### 设置 / 更新 / 遥测

| 线索 | 路径提示 |
|------|----------|
| 用户设置 | `AppUserSettingsStore.cs` |
| 设置页 VM | `SettingsPageViewModel.cs` |
| 更新应用 | `LauncherUpdateApplier.cs` |
| 旧配置迁移 | `LegacyConfigurationMigrationService.cs` |

### 主题

主题与资源在 `SVL.Avalonia/Resources/`、`Assets/`。**待核实**具体文件名列表（勿再写旧 `Themes/Light.xaml` 结构）。

---

## 相关文档

- [技术栈](./Tech-Stack)
- [构建项目](./Building)
- [贡献指南](../community/Contributing)
