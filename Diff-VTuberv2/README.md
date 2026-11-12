<!-- Owner: src/bot.ts (BotDefinition), src/core/types.ts (CoreApi, Persona, World) -->

# Diff-VTuberv2

## Quick Start

Requires Node 22+.

```bash
corepack pnpm install
pnpm start
```

### 1. First Launch & WebUI
On your first launch with an empty deployment directory, The launcher automatically initializes a default deployment named `mybot` (using the reference bot `cormini` with console chat enabled) and spins up the WebUI at:

**`http://127.0.0.1:7788/`**

The console page opens with three onboarding steps: configure a model endpoint, inspect active Worlds, and adjust the system prompt. Once an endpoint is configured, click **Say hello** to let the bot initiate conversation. All endpoints, credentials, and runtime parameters can be adjusted directly from the WebUI; saved changes apply to the next request, and a managed runtime's launch parameters apply on its next start.

The WebUI starts in `language` from `config.json`, else `DIFF_VTUBERV2_LANGUAGE`, else the system locale (Simplified Chinese when no locale is available). Settings → General switches it for the current browser without restarting the bot.

### 2. Managing Deployments
Each deployment is an isolated configuration directory inside `deployments/` (see [deployment.md](docs/deployment.md)). To add another one:

```bash
pnpm start --new
```

Pick a bot package, a directory name and a display name; the new deployment starts right away, with endpoints and everything else configured from the WebUI. To start a specific deployment by name:

```bash
pnpm start second
```

The launcher scripts (`pnpm start`, `./start.sh`, and `start.bat` on Windows) automatically install missing dependencies, build WebUI assets when they are missing or older than the source, list every deployment for selection on an interactive terminal (including an entry for creating a new one), and restart processes on request from the WebUI.

## The Four Layers

The framework separates responsibilities across these layers:

| Layer | Responsibility | Directory |
|---|---|---|
| **Core** | Manages session lifecycles, event streams, and model invocations. Semantics-free. | `src/core/` |
| **Persona** | Defines the semantics of a bot category: context synthesis, cognitive loop, and Memory protocols. | `bots/<name>/persona/` |
| **Memory** | The authoritative persistence store for internal state; layout and lifecycle are chosen by the Persona. | `<deployment>/memory/` |
| **World** | The isolated boundary to an external environment: event ingestion, tool declarations, and environment prompts. | `src/worlds/<id>/` |
| **Bot** | Assembly definition: couples one Persona with a designated set of Worlds. | `bots/<name>/index.ts` |

## Documentation

| Document | Topic |
|---|---|
| [deployment.md](docs/deployment.md) | Deployment layouts, deployment roots, and launcher behaviors |
| [configuration.md](docs/configuration.md) | Four-layer config cascading, configuration groups, and hot reload |
| [providers.md](docs/providers.md) | Provider modules, model catalogs, endpoint configurations, and pricing |
| [runtimes.md](docs/runtimes.md) | Local runtimes and model files for `llamacpp` |
| [webui.md](docs/webui.md) | WebUI architecture, live monitoring, and custom module pages |
| [sessions.md](docs/sessions.md) | Session lifecycle, token capacity management, and context handoff |
| [runs.md](docs/runs.md) | Runtime directories, structured logs, and `pnpm logq` CLI |
| [personas.md](docs/personas.md) | Persona lifecycle hooks, Memory architecture, and bot assembly |
| [worlds.md](docs/worlds.md) | The World contract: events, tools, and environment prompts |
| [world-compatibility.md](docs/world-compatibility.md) | Compatibility levels for other bot architectures mounting Worlds |
| [extensions.md](docs/extensions.md) | Extension package specifications, manifests, and dynamic loading |
| [environment-variables.md](docs/environment-variables.md) | `DIFF_VTUBERV2_*` environment configuration and the `.env` hierarchy |
| [windows.md](docs/windows.md) | Windows environment compatibility and setup |
| [development.md](docs/development.md) | Development workflows, dual tsconfig setup, and test architecture |

## Built-in Worlds

| World | ID | Integration & Capabilities |
|---|---|---|
| Console | `console` | Interactive two-way conversation within the WebUI |
| QQ | `qq` | Multi-group and direct message channels with optional vision model transcription |
| Bilibili Live | `bilibili` | Real-time danmaku, superchats, gifts, guards, and viewer traffic monitoring with local OBS overlay |
| Minecraft | `minecraft` | Mineflayer client for vanilla servers: game state observations and high-level autonomous action dispatch |
| Web Search | `websearch` | Real-time web search through the Brave Search API or the DeepSeek Search API; either address can point at a compatible proxy |

Each release also publishes `minecraft`, `qq`, `bilibili` and `websearch` to npm as `diff-vtuberv2-world-<id>` at the framework's version, for apps built on this framework that do not bundle them. Where the framework already has a World with the same id, the installed package is not loaded.

## Model Providers

| Provider | Supported Services |
|---|---|
| `openai-responses-compat` | Any model API supporting the Responses protocol specification |
| `llamacpp` | Local `llama-server` runtime with automated binary download and process management |

Additional upstream protocols and providers can be integrated seamlessly via extensions.

## Development checks

* Refer to [AGENTS.md](AGENTS.md) for our engineering conventions and code review checklist.
* AI-assisted contributions are welcome, provided the author thoroughly understands and can explain all submitted logic.
* WebUI text lives in `strings.ts` (complete in `zh` and `en`) with each other language in `strings.<lang>.ts` beside it; a key a translation leaves out falls back to `zh` for `zh-Hant` and to `en` for the rest. See the language section of [webui.md](docs/webui.md#语言).

Run automated verifications during development:

```bash
pnpm test
pnpm run typecheck
```

For changes touching frontend browser code, also run:

```bash
pnpm typecheck:web
pnpm build:web
```
