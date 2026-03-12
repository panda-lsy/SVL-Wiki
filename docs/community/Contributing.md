# 对 Wiki 进行贡献

感谢你有兴趣为 SVL Wiki 做出贡献！本文档将帮助你了解如何参与 Wiki 的编写和改进。

## 贡献类型

Wiki 接受以下几种类型的贡献：

| 贡献类型                 | 说明                                                       | 相关文档                                   |
| ------------------------ | ---------------------------------------------------------- | ------------------------------------------ |
| **Wiki 内容贡献**  | 改进文档、添加教程、修复错误                               | 本文档                                     |
| **社区资源本地化** | 为 Mod、整合包在 Curseforge/NexusMods 上的信息添加中文翻译 | [本地化贡献指南](./Localization-Contributing) |

## 官方预览渠道

Wiki 目前有四个官方预览渠道：

| 渠道                | 地址                                                                                                                        | 说明                                                   |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| Wiki 仓库 Wiki      | [https://github.com/panda-lsy/SVL-Wiki/wiki](https://github.com/panda-lsy/SVL-Wiki/wiki)                                       | GitHub Wiki 原生预览                                   |
| SVL 启动器仓库 Wiki | [https://github.com/panda-lsy/SVL-StardewValleyLauncher/wiki](https://github.com/panda-lsy/SVL-StardewValleyLauncher/wiki)     | 主项目仓库的 Wiki                                      |
| Gitee Wiki          | [https://gitee.com/mc_shengxia/SVL-StardewValleyLauncher/wikis](https://gitee.com/mc_shengxia/SVL-StardewValleyLauncher/wikis) | Gitee 镜像 Wiki                                        |
| 阿里云挂载 Wiki     | [https://marki.89b52195.er.aliyun-esa.net/](https://marki.89b52195.er.aliyun-esa.net/)                                         | 由[Marki](https://github.com/Freakz3z/Marki) 提供技术支持 |

## 自动同步机制

所有四个渠道都会自动从 [SVL-Wiki 仓库](https://github.com/panda-lsy/SVL-Wiki) 加载内容：

```
┌─────────────────────────────────────┐
│       SVL-Wiki 仓库 (源)            │
│   https://github.com/panda-lsy/SVL-Wiki
└──────────────┬──────────────────────┘
               │ 自动同步
       ┌───────┼───────┬───────┐
       ▼       ▼       ▼       ▼
   ┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐
   │ Wiki  │ │ 启动器│ │ Gitee │ │ 阿里云│
   │ 仓库  │ │  Wiki │ │  Wiki │ │ Marki │
   └───────┘ └───────┘ └───────┘ └───────┘
```

当仓库更新时，GitHub Actions 会自动将内容同步到所有预览渠道。

## 贡献方式概述

你可以通过以下方式为 Wiki 做出贡献：

| 贡献方式                 | 难度        | 适合人群        |
| ------------------------ | ----------- | --------------- |
| 修复错别字/格式          | ⭐ 简单     | 所有用户        |
| 补充文档内容             | ⭐⭐ 中等   | 熟悉功能的用户  |
| 编写新教程               | ⭐⭐⭐ 较难 | 有经验的用户    |
| 改进文档结构             | ⭐⭐⭐ 较难 | 熟悉项目的用户  |
| **社区资源本地化** | ⭐⭐ 中等   | 熟悉 Mod 的用户 |

> 📚 **社区资源本地化**：为 Mod、整合包添加中文翻译，详见 [本地化贡献指南](./Localization-Contributing)。

## 快速开始

### 1. Fork 仓库

1. 访问 [SVL-Wiki](https://github.com/panda-lsy/SVL-Wiki) 仓库
2. 点击右上角的 **Fork** 按钮
3. 等待 Fork 完成，进入你的 Fork 仓库

### 2. 克隆到本地

```bash
git clone https://github.com/你的用户名/SVL-Wiki.git
cd SVL-Wiki
```

### 3. 创建贡献分支

```bash
git checkout -b docs/你的修改描述
```

分支命名建议：

- `docs/fix-typo-in-installation` - 修复安装文档错别字
- `docs/add-mod-management-guide` - 添加 Mod 管理指南
- `docs/update-screenshots` - 更新截图

### 4. 进行修改

根据你要贡献的内容类型进行编辑：

#### 修改现有文档

- 打开对应的 `.md` 文件
- 进行编辑并保存
- 确保链接和图片路径正确

#### 添加新文档

1. 在合适的目录下创建新文件
2. 添加文档内容
3. 更新 `SUMMARY.md`、`_Sidebar.md` 和 `README.md` 的导航

### 5. 提交更改

```bash
git add .
git commit -m "docs: 描述你的修改"
```

提交信息规范：

- `docs: ` 前缀表示文档更新
- 简洁描述修改内容
- 例如：`docs: 修复安装指南中的链接错误`

### 6. 推送并创建 PR

```bash
git push origin docs/你的修改描述
```

然后在 GitHub 上创建 Pull Request：

1. 访问你的 Fork 仓库
2. 点击 **Compare & pull request**
3. 填写 PR 标题和描述
4. 点击 **Create pull request**

## 文档编写规范

### Markdown 格式

- 使用 ATX 风格的标题（`#` 而不是 `=`）
- 代码块标注语言类型
- 列表使用 `-` 或 `*`
- 链接使用相对路径

### 内容规范

1. **准确性**：确保内容与实际功能一致
2. **完整性**：步骤清晰，不遗漏关键信息
3. **可读性**：语言简洁，结构清晰
4. **一致性**：术语统一，风格一致

### 图片规范

- 使用 PNG 或 JPG 格式
- 宽度建议不超过 800px
- 存放在 `images/` 目录下
- 使用相对路径引用：`./images/xxx.png`

## 文档结构说明

```
docs/
├── tutorials/          # 使用教程
│   ├── Installation.md
│   ├── Getting-Started.md
│   ├── Creating-Instance.md
│   └── Installing-Mods.md
├── features/           # 功能文档
│   ├── Instance-Management.md
│   ├── Mod-Management.md
│   ├── NexusMods-Integration.md
│   ├── Modpack-Support.md
│   ├── Download-Manager.md
│   ├── SMAPI-Management.md
│   ├── Theming.md
│   ├── Version-Isolation.md
│   └── Settings.md
├── development/        # 开发文档
│   ├── Project-Structure.md
│   ├── Tech-Stack.md
│   └── Building.md
├── community/          # 社区贡献
│   ├── Contributing.md           # 本文档
│   └── Localization-Contributing.md  # 本地化贡献指南
└── scripts/            # 脚本工具
```

## 预览你的修改

### 本地预览

你可以使用以下工具在本地预览 Wiki：

**使用 GitBook CLI：**

```bash
npm install -g gitbook-cli
gitbook serve
```

**使用 MkDocs：**

```bash
pip install mkdocs
mkdocs serve
```

**使用 VS Code 插件：**

- Markdown Preview Enhanced
- GitHub Markdown Preview

### 在线预览

提交 PR 后，可以通过以下方式预览：

1. GitHub 的 Markdown 预览
2. 等待同步到预览渠道查看效果

## 审核流程

你的 PR 提交后会经过以下流程：

1. **自动检查**：GitHub Actions 检查格式
2. **人工审核**：维护者审核内容
3. **修改反馈**：如有问题会提出修改建议
4. **合并发布**：审核通过后合并到主分支

## 贡献者权益

- 在 Git 提交记录中留名
- 被列入项目贡献者名单
- 获得社区认可和感谢

## 其他贡献方式

### 报告问题

如果你发现文档有问题但不想自己修改：

1. 访问 [Issues](https://github.com/panda-lsy/SVL-Wiki/issues)
2. 点击 **New issue**
3. 选择 **Documentation** 模板
4. 描述问题详情

### 提供反馈

- 在文档页面底部评论
- 加入社区讨论群
- 发送邮件给维护者

## 获取帮助

如果你在贡献过程中需要帮助：

- 查看 [GitHub Docs](https://docs.github.com/cn) 了解 Git 和 GitHub 使用
- 在 [Issues](https://github.com/panda-lsy/SVL-Wiki/issues) 中提问
- 在 PR 中 @ 维护者
- 参考其他优秀的开源文档项目

## 相关资源

- [SVL 主仓库](https://github.com/panda-lsy/SVL-StardewValleyLauncher)
- [SVL Wiki 仓库](https://github.com/panda-lsy/SVL-Wiki)
- [Markdown 指南](https://www.markdownguide.org/)
- [GitHub Markdown 文档](https://docs.github.com/cn/github/writing-on-github)
- [社区资源本地化贡献指南](./Localization-Contributing)

---

感谢你的贡献！每一份努力都让 Wiki 变得更好 🎉
