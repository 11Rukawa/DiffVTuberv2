# Diff-VTuberv2

| 目录 | 内容 |
|---|---|
| [Diff-VTuberv2](Diff-VTuberv2/README_zh.md) | 主程序、WebUI、模型接入和环境扩展 |
| [diff-vtuberv2-world-vtuber](diff-vtuberv2-world-vtuber/README.md) | VTuber 演出与语音扩展 |
| [Cortina](Cortina/README_zh.md) | 扩展开发辅助工作区 |
| [META-TINA](META-TINA/README.md) | 文本应用构建工具 |
| [ThereIsNoApp](ThereIsNoApp/README.md) | 文本应用规范参考 |

## 开始开发

需要 Node.js 22 或以上版本。在主程序目录执行：

```bash
cd Diff-VTuberv2
corepack pnpm install
pnpm start
```

开发命令和架构说明见 [主程序文档](Diff-VTuberv2/docs/development.md)。
忽略规则统一放在根目录 [.gitignore](.gitignore)。

## 命名

- 展示名称：`Diff-VTuberv2`。
- 主程序包和导入前缀：`diff-vtuberv2`、`diff-vtuberv2/*`。
- 扩展清单字段：`diffVTuberv2`。
- 环境变量前缀：`DIFF_VTUBERV2_`。
- [源码仓库](https://github.com/11Rukawa/DiffVTuberv2)。

VTuber 扩展通过本地链接依赖主程序，无需从 npm 下载尚未发布的新包。
已有部署需同步使用新的环境变量前缀和扩展清单字段；浏览器本地设置使用新的存储键。
