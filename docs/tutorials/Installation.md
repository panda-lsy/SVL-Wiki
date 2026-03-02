# 安装指南

本指南将帮助你下载和安装 SVL 启动器。

## 📋 目录

- [系统要求](#系统要求)
- [下载 SVL](#下载-svl)
- [安装步骤](#安装步骤)
- [首次运行](#首次运行)
- [常见问题](#常见问题)

## 系统要求

### 最低要求

| 项目 | 要求 |
|------|------|
| **操作系统** | Windows 10 / 11 |
| **运行时** | .NET Framework 4.8（Windows 10+ 已内置） |
| **内存** | 4 GB RAM |
| **磁盘空间** | 200 MB（启动器）+ 游戏空间 |

### 推荐配置

| 项目 | 推荐 |
|------|------|
| **操作系统** | Windows 11 |
| **内存** | 8 GB RAM 或以上 |
| **磁盘空间** | SSD 固态硬盘 |

### 游戏要求

- Stardew Valley（Steam 或 GOG 版本）
- 游戏版本 1.5.5 或更高

## 下载 SVL

### 从 GitHub Releases 下载（推荐）

1. 访问 [Releases 页面](https://github.com/panda-lsy/SVL-StardewValleyLauncher/releases)
2. 找到最新版本
3. 下载 `SVL.Desktop_x.x.x.zip` 文件
4. 解压到任意目录

### 版本说明

| 类型 | 说明 |
|------|------|
| **Stable** | 稳定版，推荐大多数用户 |
| **Pre-release** | 预发布版，包含最新功能但可能不稳定 |

## 安装步骤

### 便携版（推荐）

SVL 是便携软件，无需安装：

1. 解压下载的 ZIP 文件
2. 将文件夹移动到你想要的位置（如 `D:\Tools\SVL`）
3. 运行 `SVL.Desktop.exe`

### 创建桌面快捷方式

1. 右键点击 `SVL.Desktop.exe`
2. 选择 **「发送到」** → **「桌面快捷方式」**

### 关联 NXM 协议

首次运行时，SVL 会提示是否关联 `nxm://` 协议。

关联后可以：
- 从 NexusMods 网站一键下载 Mod
- 浏览器点击直接打开 SVL

## 首次运行

### 1. 选择游戏路径

首次运行时，SVL 会尝试自动检测游戏路径：

- **Steam**: `C:\Program Files (x86)\Steam\steamapps\common\Stardew Valley`
- **GOG**: `C:\GOG Games\Stardew Valley`

如果检测失败，请手动选择。

### 2. 创建第一个实例

1. 点击主页的 **「+」** 按钮
2. 输入实例名称（如「我的第一个实例」）
3. 选择游戏基础路径
4. 点击 **「创建」**

### 3. 安装 SMAPI

1. 选择刚创建的实例
2. 点击 **「安装 SMAPI」**
3. 选择版本并等待安装

### 4. 开始使用

现在你可以：
- 搜索和安装 Mod
- 启动游戏
- 探索更多功能

## 常见问题

### Q: 提示缺少 .NET Framework 4.8

**A:** Windows 10 1903+ 和 Windows 11 已内置。如需安装：
1. 访问 [Microsoft 下载中心](https://dotnet.microsoft.com/download/dotnet-framework/net48)
2. 下载并安装

### Q: 游戏路径检测失败

**A:** 手动选择游戏路径：
1. 点击 **「浏览」** 按钮
2. 找到 Stardew Valley 安装目录
3. 选择包含 `Stardew Valley.exe` 的文件夹

### Q: 启动器无法启动

**A:** 尝试以下步骤：
1. 以管理员身份运行
2. 检查杀毒软件是否拦截
3. 重新下载最新版本

### Q: 如何更新 SVL？

**A:** 
1. SVL 会自动检查更新
2. 也可以手动下载新版本覆盖

---

## 下一步

- [初次使用指南](./Getting-Started)
- [创建游戏实例](./Creating-Instance)
- [安装 Mod](./Installing-Mods)
