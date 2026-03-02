# 贡献指南

感谢你有兴趣为 SVL 做出贡献！

## 📋 目录

- [行为准则](#行为准则)
- [如何贡献](#如何贡献)
- [开发流程](#开发流程)
- [代码规范](#代码规范)
- [提交信息](#提交信息)
- [Pull Request](#pull-request)

## 行为准则

### 我们的承诺

为了营造开放和友好的环境，我们承诺：

- 尊重所有贡献者
- 接受建设性批评
- 关注对社区最有利的事情
- 对其他社区成员表示同理心

### 不可接受的行为

- 使用性化的语言或图像
- 骚扰、侮辱或贬低性评论
- 未经许可发布他人私人信息
- 其他不道德或不专业的行为

## 如何贡献

### 报告 Bug

1. 在 [Issues](https://github.com/panda-lsy/SVL-StardewValleyLauncher/issues) 中搜索是否已有相同问题
2. 如果没有，创建新 Issue
3. 使用 Bug 报告模板
4. 提供详细信息：
   - 操作系统版本
   - SVL 版本
   - 复现步骤
   - 预期行为
   - 实际行为
   - 截图/日志

### 建议功能

1. 在 Issues 中创建功能请求
2. 详细描述功能需求
3. 说明使用场景
4. 等待维护者评估

### 提交代码

1. Fork 仓库
2. 创建功能分支
3. 编写代码
4. 提交 Pull Request

## 开发流程

### 1. Fork 和 Clone

```bash
# Fork 后 clone 你的仓库
git clone https://github.com/YOUR_USERNAME/SVL-StardewValleyLauncher.git

# 添加上游仓库
git remote add upstream https://github.com/panda-lsy/SVL-StardewValleyLauncher.git
```

### 2. 创建分支

```bash
# 更新主分支
git checkout main
git pull upstream main

# 创建功能分支
git checkout -b feature/your-feature-name
```

### 3. 开发

```bash
# 编写代码...
# 定期提交
git add .
git commit -m "feat: 添加新功能"
```

### 4. 同步上游

```bash
# 保持与上游同步
git fetch upstream
git merge upstream/main
```

### 5. 推送和 PR

```bash
# 推送到你的 fork
git push origin feature/your-feature-name

# 在 GitHub 上创建 Pull Request
```

## 代码规范

### C# 编码规范

遵循 Microsoft C# 编码约定：

```csharp
// 类名使用 PascalCase
public class ModManager
{
    // 私有字段使用 _camelCase
    private readonly List<ModInfo> _mods;
    
    // 公共属性使用 PascalCase
    public int ModCount { get; set; }
    
    // 方法使用 PascalCase
    public void InstallMod(string path)
    {
        // ...
    }
    
    // 参数使用 camelCase
    private void ProcessMod(ModInfo modInfo)
    {
        // 局部变量使用 camelCase
        var modName = modInfo.Name;
    }
}
```

### XAML 规范

```xml
<!-- 使用有意义的命名 -->
<Grid x:Name="ModListGrid">
    <!-- 属性按字母顺序排列 -->
    <ListView Name="ModListView"
              ItemsSource="{Binding Mods}"
              SelectedItem="{Binding SelectedMod}">
    </ListView>
</Grid>
```

### 注释规范

```csharp
/// <summary>
/// 安装 Mod 到指定实例。
/// </summary>
/// <param name="instanceId">目标实例 ID</param>
/// <param name="modPath">Mod 文件路径</param>
/// <returns>安装成功返回 true</returns>
public bool InstallMod(Guid instanceId, string modPath)
{
    // 检查参数
    if (string.IsNullOrEmpty(modPath))
        throw new ArgumentNullException(nameof(modPath));
    
    // TODO: 实现安装逻辑
}
```

## 提交信息

### 格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型

| 类型 | 说明 |
|------|------|
| **feat** | 新功能 |
| **fix** | Bug 修复 |
| **docs** | 文档更新 |
| **style** | 代码格式（不影响功能） |
| **refactor** | 重构 |
| **perf** | 性能优化 |
| **test** | 测试相关 |
| **chore** | 构建/工具相关 |

### 示例

```
feat(mod): 添加 Mod 冲突检测功能

- 实现依赖关系分析
- 添加冲突警告提示
- 更新 Mod 管理界面

Closes #123
```

## Pull Request

### PR 检查清单

提交 PR 前，确保：

- [ ] 代码能正常编译
- [ ] 遵循代码规范
- [ ] 添加必要的注释
- [ ] 更新相关文档
- [ ] 提交信息格式正确
- [ ] 没有引入新的警告

### PR 模板

```markdown
## 变更类型
- [ ] Bug 修复
- [ ] 新功能
- [ ] 重构
- [ ] 文档更新

## 描述
简要描述此 PR 的内容

## 相关 Issue
Closes #

## 测试
描述如何测试此变更

## 截图
如有 UI 变更，添加截图
```

### 审核流程

1. 维护者会审核你的代码
2. 可能会提出修改建议
3. 根据反馈进行修改
4. 审核通过后合并

---

## 联系方式

- **Issues**: [GitHub Issues](https://github.com/panda-lsy/SVL-StardewValleyLauncher/issues)
- **Discussions**: [GitHub Discussions](https://github.com/panda-lsy/SVL-StardewValleyLauncher/discussions)

---

感谢你的贡献！🎉
