# 为 Wiki 作出贡献

感谢你有兴趣为 SVL Wiki 作出贡献！本文档将帮助你了解如何参与 Wiki 的编写和改进。

## 官方预览渠道

Wiki 目前有三个官方预览渠道：

| 渠道 | 地址 | 说明 |
|------|------|------|
| Wiki 仓库 Wiki | [https://github.com/panda-lsy/SVL-Wiki/wiki](https://github.com/panda-lsy/SVL-Wiki/wiki) | GitHub Wiki 原生预览 |
| SVL 启动器仓库 Wiki | [https://github.com/panda-lsy/SVL-StardewValleyLauncher/wiki](https://github.com/panda-lsy/SVL-StardewValleyLauncher/wiki) | 主项目仓库的 Wiki |
| 阿里云挂载 Wiki | [https://marki.89b52195.er.aliyun-esa.net/](https://marki.89b52195.er.aliyun-esa.net/) | 由 [Marki](https://github.com/Freakz3z/Marki) 提供技术支持 |

## 自动同步机制

所有三个渠道都会自动从 [SVL-Wiki 仓库](https://github.com/panda-lsy/SVL-Wiki) 加载内容：

```
┌─────────────────────────────────────┐
│       SVL-Wiki 仓库 (源)            │
│   https://github.com/panda-lsy/SVL-Wiki
└──────────────┬──────────────────────┘
               │ 自动同步
       ┌───────┼───────┐
       ▼       ▼       ▼
   ┌───────┐ ┌───────┐ ┌───────┐
   │ Wiki  │ │ 启动器│ │ 阿里云│
   │ 仓库  │ │  Wiki │ │ Marki │
   └───────┘ └───────┘ └───────┘
```

当仓库更新时，GitHub Actions 会自动将内容同步到所有预览渠道。

## 如何贡献

### 通过 Pull Request

1. **Fork 仓库**
   - 访问 [SVL-Wiki](https://github.com/panda-lsy/SVL-Wiki)
   - 点击右上角的 "Fork" 按钮

2. **克隆你的 Fork**
   ```bash
   git clone https://github.com/你的用户名/SVL-Wiki.git
   cd SVL-Wiki
   ```

3. **创建分支**
   ```bash
   git checkout -b docs/你的修改内容
   ```

4. **进行修改**
   - 编辑或添加 Markdown 文件
   - 确保遵循现有的文档结构

5. **提交更改**
   ```bash
   git add .
   git commit -m "docs: 简短描述你的修改"
   ```

6. **推送并创建 PR**
   ```bash
   git push origin docs/你的修改内容
   ```
   - 然后在 GitHub 上创建 Pull Request

### 文档结构

```
SVL-Wiki/
├── README.md           # 首页
├── SUMMARY.md          # 目录（GitBook 格式）
├── _Sidebar.md         # 侧边栏（GitHub Wiki）
├── images/             # 图片资源
├── docs/
│   ├── tutorials/      # 教程文档
│   ├── features/       # 功能文档
│   ├── development/    # 开发文档
│   └── CONTRIBUTING.md # 本文档
└── scripts/            # 脚本工具
```

### 文档规范

- 使用清晰的标题层级
- 添加适当的代码块和示例
- 确保链接有效
- 使用相对路径引用图片

## 获取帮助

如果你有任何问题，可以：

- 在 [Issues](https://github.com/panda-lsy/SVL-Wiki/issues) 中提问
- 在 PR 中 @ 维护者寻求帮助

感谢你的贡献！🎉
