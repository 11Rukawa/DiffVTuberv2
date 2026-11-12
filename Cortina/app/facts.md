# 事实(2026-10-22)

会过期的东西都在这里,过期只改这一份。

## 主程序源码

- 使用当前Diff-VTuberv2中的 `Diff-VTuberv2/` 目录。原则、模板和扩展契约以本地源码为准。
- 不自动克隆或更新原项目仓库，也不自动初始化 Git。
- 若流程需要 `state/diff-vtuberv2/`，先向开发者确认本地源码位置。

## 环境

- Node 22 以上;pnpm 由 corepack 按 `package.json` 的 `packageManager` 钉版本(现在是 11);git。
- 出路:Node 装 nodejs.org 的 LTS;corepack 没启用就 `corepack enable`;GitHub 到不了就从本地
  路径 clone。

## 命令

| 在哪 | 命令 | 作用 |
|---|---|---|
| 包目录 | `corepack pnpm install` | 装依赖 |
| 包目录 | `pnpm typecheck && pnpm test` | 第一级 |
| `state/diff-vtuberv2/` | `pnpm describe:extension <包目录>` | 写自描述 `describe.json`;工具、事件或提示词改了就重跑 |
| `state/diff-vtuberv2/` | `pnpm check:extension <包目录>` | 第二级,含干装载与自描述核对;最后两段列标签与发布前清单 |
| 开发者的实例 | WebUI「扩展」页「手动安装」里选「从本机目录安装」,选包目录,重启进程 | 第三级的前置,由开发者做 |

## 扩展市场

使用开发者配置的索引源。当前不声明原项目的维护者、认证或申请渠道。
