# 设置与配置

SVL 提供丰富的设置选项，让你可以自定义启动器的行为。

## 📋 目录

- [打开设置](#打开设置)
- [通用设置](#通用设置)
- [外观设置](#外观设置)
- [下载设置](#下载设置)
- [NexusMods 设置](#nexusmods-设置)
- [高级设置](#高级设置)
- [配置文件](#配置文件)

## 打开设置

- 点击左侧边栏的 **「设置」** 图标
- 或使用快捷键 `Ctrl + ,`

## 通用设置

| 设置 | 说明 |
|------|------|
| **语言** | 界面语言（中文/英文） |
| **启动时检查更新** | 自动检查启动器更新 |
| **最小化到托盘** | 关闭时最小化到系统托盘 |
| **开机自启动** | Windows 启动时自动运行 |

### 游戏路径

| 设置 | 说明 |
|------|------|
| **游戏基础路径** | Stardew Valley 的安装目录 |
| **自动检测** | 自动检测 Steam/GOG 游戏路径 |
| **多路径支持** | 添加多个游戏安装路径 |

## 外观设置

| 设置 | 说明 |
|------|------|
| **主题** | 浅色/深色/跟随系统 |
| **强调色** | 界面强调颜色 |
| **动画效果** | 开启/关闭界面动画 |
| **字体大小** | 界面文字大小 |

详见 [主题与外观](./Theming)

## 下载设置

| 设置 | 说明 |
|------|------|
| **并发下载数** | 同时下载的任务数量（1-5） |
| **下载目录** | 下载文件的保存位置 |
| **下载后自动安装** | 下载完成自动安装到当前实例 |
| **代理设置** | HTTP/SOCKS 代理配置 |

详见 [下载管理器](./Download-Manager)

## NexusMods 设置

| 设置 | 说明 |
|------|------|
| **登录状态** | 显示当前登录状态 |
| **API Key** | 手动输入 API Key |
| **NXM 协议** | 启用浏览器一键安装 |
| **API 配额** | 查看剩余 API 请求次数 |

详见 [NexusMods 集成](./NexusMods-Integration)

## 高级设置

### 调试选项

| 设置 | 说明 |
|------|------|
| **调试模式** | 启用详细日志 |
| **打开日志目录** | 打开日志文件夹 |
| **清除缓存** | 清除所有缓存数据 |

### 数据管理

| 设置 | 说明 |
|------|------|
| **数据目录** | SVL 数据存储位置 |
| **备份设置** | 导出/导入设置 |
| **重置设置** | 恢复默认设置 |

## 配置文件

### 位置

| 文件 | 位置 | 格式 |
|------|------|------|
| **全局配置** | `%LocalAppData%\SVL\config.yaml` | YAML |
| **实例配置** | `%LocalAppData%\SVL\instances\{id}\instance.json` | JSON |
| **NexusMods 缓存** | `%LocalAppData%\SVL\cache\nexusmods\` | - |

### config.yaml 示例

```yaml
# SVL 全局配置
general:
  language: zh-CN
  autoCheckUpdate: true
  minimizeToTray: false

appearance:
  theme: dark
  accentColor: "#6366F1"

download:
  concurrentDownloads: 3
  downloadPath: "%LocalAppData%\\SVL\\downloads"
  autoInstall: true

nexusmods:
  apiKey: ""
  nxmProtocol: true
```

### instance.json 示例

```json
{
  "id": "my-instance",
  "name": "我的实例",
  "path": "D:\\Games\\StardewValley\\Instances\\my-instance",
  "description": "描述信息",
  "logo": "",
  "isStarred": false,
  "enableIsolation": true,
  "smapiVersion": "4.1.1",
  "modCount": 25,
  "lastPlayed": "2024-01-15T10:30:00Z"
}
```

---

## 相关文档

- [主题与外观](./Theming)
- [下载管理器](./Download-Manager)
- [NexusMods 集成](./NexusMods-Integration)
