<!-- Owner: src/bot.ts (BotDefinition), src/core/types.ts (CoreApi, Persona, World) -->

# Diff-VTuberv2

## 快速开始

运行环境需 Node 22+。

```bash
corepack pnpm install
pnpm start
```

### 1. 首次启动与 WebUI 引导
首次启动且未检测到已有部署时，启动器会自动创建名为 `mybot` 的默认部署（基于参考实现 `cormini`，默认启用控制台对话），并自动启动 WebUI 服务：

**`http://127.0.0.1:7788/`**

在 WebUI 的控制台页面中，开场引导将协助你完成三项基础配置：配置语言模型端点、查看已挂载的 World、调整系统提示词。配置好可用端点后，点击「打个招呼」即可让 Bot 主动开口交流。模型端点、API 密钥与运行参数均可在 WebUI 中可视化修改，保存后下一次请求生效；托管运行时的启动参数在它下一次启动时生效。

WebUI 的初始语言依次取 `config.json` 的 `language`、`DIFF_VTUBERV2_LANGUAGE`、系统区域（读不到区域时用简体中文）。在「设置 → 通用」里切换，只对当前浏览器生效，不用重启 bot。

### 2. 多部署管理
每个部署对应 `deployments/` 下的一个独立子目录（详见 [deployment.md](docs/deployment.md)）。再建一份：

```bash
pnpm start --new
```

依次选择 bot 代码包、部署目录名与展示名称，建好后直接启动，端点等其余配置在 WebUI 中完成。按名称启动指定部署：

```bash
pnpm start second
```

启动脚本（`pnpm start`、`./start.sh` 或 Windows 上的 `start.bat`）会自动安装缺失依赖、在 WebUI 前端产物缺失或落后于源码时构建，在交互式命令行中列出全部部署供选择（含新建部署入口），并在 WebUI 请求重启时自动重启守护进程。

## 四层设计

框架按以下层级划分职责：

| 层级 | 核心职责 | 所在路径 |
|---|---|---|
| **Core** | 管理会话（Session）、事件流分发与模型调用生命周期；内部无业务语义。 | `src/core/` |
| **Persona** | 定义一类 Bot 的核心语义：上下文构造、认知循环与对 Memory 的读写协议。 | `bots/<名称>/persona/` |
| **Memory** | Bot 内部持久化状态的唯一权威载体，结构与组织形态由 Persona 决定。 | `<部署>/memory/` |
| **World** | 与单个外部环境交互的隔离边界：处理环境事件输入、工具声明与环境提示词。 | `src/worlds/<id>/` |
| **Bot** | 部署装配定义：将一个指定的 Persona 与一组 World 组装成可运行实例。 | `bots/<名称>/index.ts` |

## 文档

| 页面 | 内容索引 |
|---|---|
| [deployment.md](docs/deployment.md) | 部署目录结构、部署根路径与启动器工作机制 |
| [configuration.md](docs/configuration.md) | 四层配置合并规则、配置组定义与参数热更新 |
| [providers.md](docs/providers.md) | Provider 模块、模型目录、端点配置与计费策略 |
| [runtimes.md](docs/runtimes.md) | `llamacpp` 本机运行时管理与模型文件配置 |
| [webui.md](docs/webui.md) | WebUI 架构、运行时监控与各模块页面声明 |
| [sessions.md](docs/sessions.md) | Session 生命周期、上下文容量调度与交接机制 |
| [runs.md](docs/runs.md) | 运行记录目录、日志结构与 `pnpm logq` 检索工具 |
| [personas.md](docs/personas.md) | Persona 生命周期钩子、Memory 架构与装配机制 |
| [worlds.md](docs/worlds.md) | World 交互契约：事件投递、工具执行与环境提示词 |
| [world-compatibility.md](docs/world-compatibility.md) | 其他架构的 bot 挂载 World 的兼容等级与对照表 |
| [extensions.md](docs/extensions.md) | 扩展包规范、Manifest 定义与动态加载器 |
| [environment-variables.md](docs/environment-variables.md) | `DIFF_VTUBERV2_*` 环境变量规范与三层 `.env` 文件继承 |
| [windows.md](docs/windows.md) | Windows 环境兼容性与运行说明 |
| [development.md](docs/development.md) | 常用开发命令、双 tsconfig 架构与测试体系布局 |

## 内建 World

| World | ID | 接入环境与能力 |
|---|---|---|
| 控制台对话 | `console` | WebUI 内建的对话页，支持双向文字会话 |
| QQ | `qq` | 接入 QQ 群聊与私聊，支持可选的多模态视觉模型图像理解 |
| 哔哩哔哩直播 | `bilibili` | 实时监听弹幕、礼物、醒目留言（SC）、大航海、进场通知与人流指标，附带本机 OBS 画面 Overlay |
| Minecraft | `minecraft` | 基于 Mineflayer 接入 Minecraft 原版服务器，实现文字环境观察与高层动作执行 |
| 网页搜索 | `websearch` | 通过 Brave Search API 或 DeepSeek 搜索 API 检索实时网络信息;两家的地址都可换成兼容的代理 |

每次发版还把 `minecraft`、`qq`、`bilibili`、`websearch` 以 `diff-vtuberv2-world-<id>` 发到 npm，版本与框架相同，供不内建这些 World 的应用安装。框架里已有同 id 的 World 时，装上的包不加载。

## 模型端点

| Provider | 适配模型服务 / 说明 |
|---|---|
| `openai-responses-compat` | 支持 Responses API 协议规范的模型服务与兼容网关 |
| `llamacpp` | 本机 `llama-server` 运行时集成，支持官方 Binary 自动下载与子进程生命周期托管 |

如需接入更多模型协议与供应商，可通过扩展系统无缝安装。

## 开发检查

* 欢迎使用 AI 编码助手辅助开发，但贡献者必须能够清晰解释提交的所有代码逻辑。
* WebUI 文案放在 `strings.ts`（`zh`、`en` 两版是全的），其余语言各写在旁边的 `strings.<语言代码>.ts`；译文缺的键，`zh-Hant` 读 `zh`，其余读 `en`。详见 [webui.md](docs/webui.md#语言) 的「语言」一节。
* 开发完成后请确保自动化校验通过：

```bash
pnpm test
pnpm run typecheck
```

若涉及 WebUI 前端代码改动，需额外执行：

```bash
pnpm typecheck:web
pnpm build:web
```
