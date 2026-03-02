# 构建项目

本指南介绍如何从源代码构建 SVL 启动器。

## 📋 目录

- [环境要求](#环境要求)
- [获取源代码](#获取源代码)
- [构建步骤](#构建步骤)
- [运行调试](#运行调试)
- [发布构建](#发布构建)

## 环境要求

### 必需软件

| 软件 | 版本 | 说明 |
|------|------|------|
| **Visual Studio** | 2022 | 推荐 IDE |
| **.NET Framework** | 4.8 SDK | 目标框架 |
| **Git** | 最新版 | 版本控制 |

### Visual Studio 工作负载

安装 Visual Studio 时，确保选择：

- ✅ **.NET 桌面开发** 工作负载
- ✅ **NuGet 包管理器**

### 可选工具

| 工具 | 用途 |
|------|------|
| **dotnet CLI** | 命令行构建 |
| **VS Code** | 轻量级编辑 |

## 获取源代码

### 克隆仓库

```bash
# HTTPS
git clone https://github.com/panda-lsy/SVL-StardewValleyLauncher.git

# SSH
git clone git@github.com:panda-lsy/SVL-StardewValleyLauncher.git
```

### 进入目录

```bash
cd SVL-StardewValleyLauncher
```

### 切换分支

```bash
# 查看所有分支
git branch -a

# 切换到开发分支（如有）
git checkout develop
```

## 构建步骤

### 方法一：Visual Studio

1. 打开 `SVL.sln` 解决方案文件
2. 等待 NuGet 还原完成
3. 选择构建配置：
   - **Debug** - 调试版本
   - **Release** - 发布版本
4. 按 `Ctrl+Shift+B` 构建解决方案

### 方法二：命令行 (MSBuild)

```bash
# 还原 NuGet 包
nuget restore SVL.sln

# Debug 构建
msbuild SVL.sln /p:Configuration=Debug

# Release 构建
msbuild SVL.sln /p:Configuration=Release
```

### 方法三：dotnet CLI

```bash
# 还原依赖
dotnet restore

# 构建
dotnet build --configuration Release
```

## 运行调试

### Visual Studio 调试

1. 设置 `SVL.Desktop` 为启动项目
2. 按 `F5` 启动调试
3. 或按 `Ctrl+F5` 运行（不调试）

### 调试配置

在 `App.config` 中可以配置调试选项：

```xml
<appSettings>
  <add key="DebugMode" value="true" />
  <add key="VerboseLogging" value="true" />
</appSettings>
```

### 调试技巧

| 技巧 | 说明 |
|------|------|
| **断点** | 在代码行左侧点击设置断点 |
| **条件断点** | 右键断点 → 条件 |
| **即时窗口** | 调试时 `Ctrl+I` |
| **监视窗口** | 调试 → 窗口 → 监视 |

## 发布构建

### Release 配置

确保使用 Release 配置构建：

```bash
msbuild SVL.sln /p:Configuration=Release
```

### 输出目录

构建输出位于：

```
src/SVL.Desktop/bin/Release/
├── SVL.Desktop.exe
├── SVL.Desktop.exe.config
├── SVL.Core.dll
├── SVL.Infrastructure.dll
└── [依赖 DLL]
```

### 打包发布

1. 创建发布目录：

```bash
mkdir publish
```

2. 复制必要文件：

```bash
xcopy src\SVL.Desktop\bin\Release\* publish\ /E /I
```

3. 移除调试文件：

```bash
del publish\*.pdb
del publish\*.xml
```

4. 创建 ZIP 包：

```bash
# PowerShell
Compress-Archive -Path publish\* -DestinationPath SVL.Desktop_v1.0.0.zip
```

### 版本号管理

在 `AssemblyInfo.cs` 中管理版本号：

```csharp
[assembly: AssemblyVersion("1.0.0.0")]
[assembly: AssemblyFileVersion("1.0.0.0")]
```

## 常见问题

### Q: NuGet 还原失败

**A:** 检查网络连接，或配置 NuGet 源：

```bash
nuget sources add -name nuget.org -source https://api.nuget.org/v3/index.json
```

### Q: 找不到 .NET Framework 4.8

**A:** 安装 .NET Framework 4.8 Developer Pack：
https://dotnet.microsoft.com/download/dotnet-framework/net48

### Q: 构建错误 "找不到类型"

**A:** 
1. 清理解决方案：`Build` → `Clean Solution`
2. 重新还原 NuGet 包
3. 重新构建

---

## 相关文档

- [项目结构](./Project-Structure)
- [技术栈](./Tech-Stack)
- [贡献指南](./Contributing)
