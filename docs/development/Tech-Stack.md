# 技术栈

本文档介绍 SVL 项目使用的技术栈和依赖项。

## 📋 目录

- [核心框架](#核心框架)
- [主要依赖项](#主要依赖项)
- [UI 框架](#ui-框架)
- [数据存储](#数据存储)
- [网络通信](#网络通信)

## 核心框架

| 技术 | 版本 | 用途 |
|------|------|------|
| **.NET Framework** | 4.8 | 运行时框架 |
| **C#** | 7.3+ | 编程语言 |
| **WPF** | - | UI 框架 |

### 为什么选择 .NET Framework 4.8？

- **Windows 兼容性** - Windows 10+ 内置，无需额外安装
- **WPF 成熟度** - 桌面应用开发的稳定选择
- **生态系统** - 丰富的 NuGet 包支持

## 主要依赖项

### MVVM 框架

| 包 | 版本 | 用途 |
|------|------|------|
| **CommunityToolkit.Mvvm** | 8.x | MVVM 模式实现 |

**功能：**
- `ObservableObject` - 属性变更通知
- `RelayCommand` - 命令绑定
- `ObservableCollection` - 集合通知

### 数据处理

| 包 | 版本 | 用途 |
|------|------|------|
| **LiteDB** | 5.x | 嵌入式数据库 |
| **YamlDotNet** | 15.x | YAML 配置解析 |
| **Newtonsoft.Json** | 13.x | JSON 序列化 |

### 文件处理

| 包 | 版本 | 用途 |
|------|------|------|
| **SharpZipLib** | 1.x | ZIP 文件处理 |

## UI 框架

### WPF 组件

| 技术 | 用途 |
|------|------|
| **XAML** | UI 布局定义 |
| **Data Binding** | 数据绑定 |
| **Styles & Templates** | 样式和模板 |
| **ResourceDictionary** | 资源管理 |

### 主题系统

SVL 使用自定义主题系统：

```
Themes/
├── Light.xaml      # 浅色主题
├── Dark.xaml       # 深色主题
└── Colors/
    ├── Blue.xaml
    ├── Green.xaml
    └── ...
```

### 值转换器

| 转换器 | 功能 |
|--------|------|
| `BoolToVisibilityConverter` | 布尔值转可见性 |
| `InverseBooleanConverter` | 布尔值取反 |
| `NullToVisibilityConverter` | 空值转可见性 |

## 数据存储

### LiteDB

嵌入式 NoSQL 数据库，用于存储：

- 实例配置
- Mod 信息缓存
- 下载历史
- 应用设置

```csharp
// 数据模型示例
public class GameInstance
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public string Path { get; set; }
    public bool IsVersionIsolated { get; set; }
    public List<ModInfo> Mods { get; set; }
}
```

### 配置文件

| 文件 | 格式 | 用途 |
|------|------|------|
| `config.yaml` | YAML | 应用配置 |
| `instances.json` | JSON | 实例列表 |
| `settings.json` | JSON | 用户设置 |

## 网络通信

### HTTP 客户端

使用 `HttpClient` 进行网络请求：

- NexusMods API 调用
- Mod 文件下载
- 更新检查

### OAuth 认证

NexusMods OAuth 2.0 流程：

```
1. 打开授权页面
2. 用户登录授权
3. 回调获取 code
4. 交换 access_token
5. 存储 token
```

### NXM 协议

处理 `nxm://` 协议链接：

```
nxm://StardewValley/mods/12345/files/67890
```

## 日志系统

使用自定义日志系统：

| 级别 | 用途 |
|------|------|
| **Debug** | 开发调试信息 |
| **Info** | 一般信息 |
| **Warning** | 警告信息 |
| **Error** | 错误信息 |

日志文件位置：`%AppData%\SVL\Logs\`

## 外部工具

### SMAPI

Stardew Modding API 集成：

- 自动下载安装
- 版本管理
- 日志解析

### 游戏集成

- 游戏路径检测
- 启动参数管理
- 进程监控

---

## NuGet 包列表

```xml
<PackageReference Include="CommunityToolkit.Mvvm" Version="8.2.2" />
<PackageReference Include="LiteDB" Version="5.0.21" />
<PackageReference Include="YamlDotNet" Version="15.1.0" />
<PackageReference Include="Newtonsoft.Json" Version="13.0.3" />
<PackageReference Include="SharpZipLib" Version="1.4.2" />
```

---

## 相关文档

- [项目结构](./Project-Structure)
- [构建项目](./Building)
- [贡献指南](../community/Contributing)
