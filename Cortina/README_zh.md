<!-- Owner: AGENTS.md, app/modes/, app/facts.md -->

# Diff-VTuberv2：扩展开发助手

这个目录保存扩展开发的操作说明与设计记录，可用于编写 World、Provider、Bot，或迁移现有实现。

## 使用

1. 用编程助手打开本目录，说明要实现的功能。
2. 使用上级目录 `Diff-VTuberv2/` 中的主程序源码、文档和模板。
3. 在 `state/packages/` 下开发扩展，在 `state/design/` 中记录设计。
4. 在包目录运行类型检查与测试，再从主程序目录检查扩展契约。

## 文件

- [AGENTS.md](AGENTS.md)：操作约定。
- [app/](app/README.md)：阅读地图、工作流程与环境说明。
- `state/JOURNAL.md`：进度记录。
- `state/design/`：设计记录。
- `state/packages/`：扩展包。

当前工作区不自动初始化仓库或连接原项目远端。
