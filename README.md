# claude-agents-toolkit

> A curated, opinionated set of **25 Claude Code subagents** for the full stack a solo founder + quant trader actually needs: Rust/TS/Go/Python development, Web/UI/Electron, EVM smart contracts, **BTC L1 / Ordinals / BRC-20**, exchange APIs (Binance/Bybit/OKX/Polymarket), web HTTP reverse engineering, Playwright automation, VPS ops.

Built for `~/.claude/agents/`. MIT licensed. Drop-in installable.

---

## Why this exists

Most public agent collections cover web frameworks well but leave **crypto-native + ops-heavy + reverse-engineering** workflows underserved. This toolkit fills the gaps that emerged from running real systems:

- **EVM + BTC L1 in one place** — no other public collection has Ordinals/BRC-20 support next to Solidity expertise.
- **Centralized exchange APIs as first-class** — Binance/Bybit/OKX/Polymarket signing, WS auth, rate-limit handling.
- **Web HTTP reverse engineering as separate domain** — DevTools → curl → deobfuscated client, distinct from binary RE.
- **Trading bot VPS ops baked in** — systemd, journalctl, SQLite reconciliation, with safety rails.
- **All under one orchestrator** (`tech-lead-orchestrator`) so cross-stack tasks route automatically.

Selected from 6 upstream repos after careful comparison.

---

## Who should use this

- Solo technical founders shipping across web + Web3 + ops
- Quant traders running bots on multiple venues (CEX + DEX)
- Web3 / DeFi / Ordinals builders
- Anyone tired of juggling 5 different agent repos

If you only do React + Postgres, use [vijaythecoder's repo](https://github.com/vijaythecoder/awesome-claude-agents) directly — this toolkit is for the wider stack.

---

## Quick Inventory (25 agents)

| Category | Count | Agents |
|---|---|---|
| 🎯 Orchestrator | 1 | `tech-lead-orchestrator` |
| 🔧 Common | 8 | `code-reviewer`, `security-auditor`, `debugger`, `performance-engineer`, `docs-architect`, `tdd-orchestrator`, `context-manager`, `sql-pro` |
| 💻 Language | 4 | `rust-pro`, `typescript-pro`, `golang-pro`, `python-pro` |
| 🎨 Frontend | 5 | `react-pro`, `vue-component-architect`, `electron-pro`, `nextjs-pro`, `ux-designer` |
| 🤖 Automation | 1 | `playwright-expert` |
| 📡 API | 1 | `exchange-api-integrator` ⭐ custom |
| ⛓️ Blockchain | 2 | `blockchain-developer` (EVM), `btc-brc20-specialist` ⭐ custom |
| 🛠️ Custom Ops | 2 | `pmbotv8-vps-ops` ⭐ custom, `web-reverse-engineer` ⭐ custom |
| 📊 Domain | 1 | `quant-analyst` |

**Total**: 25 = 21 from upstream curation + **4 custom** (the toolkit's unique value).

---

## Agent Reference (Detailed)

### 🎯 Orchestrator (1)

#### `tech-lead-orchestrator`
Senior technical lead who analyzes complex software projects and routes work to the right specialist agents. The brain of the toolkit.
- **Use for**: Any multi-step development task, feature implementation, architectural decision
- **Triggers**: `MUST BE USED` for any multi-step task; auto-decomposes into sub-agent calls
- **Model**: `opus`
- **Source**: [vijaythecoder/awesome-claude-agents](https://github.com/vijaythecoder/awesome-claude-agents/blob/main/agents/orchestrators/tech-lead-orchestrator.md)
- **Example prompt**: *"做一个 Polygon staking dApp"* → 自动调用 `blockchain-developer` + `react-pro` + `code-reviewer`

---

### 🔧 Common (8)

#### `code-reviewer`
Rigorous, security-aware code review after every feature, bug-fix, or pull-request. Routes specialist findings to other agents.
- **Use for**: 任何代码改动后；merge 到 main 前
- **Triggers**: `MUST BE USED` after writing code; `PROACTIVELY` before merge
- **Source**: [vijaythecoder/awesome-claude-agents](https://github.com/vijaythecoder/awesome-claude-agents/blob/main/agents/core/code-reviewer.md)

#### `security-auditor`
Expert security auditor covering DevSecOps, OWASP, OAuth2/OIDC, cloud security, GDPR/HIPAA/SOC2 compliance, threat modeling, incident response.
- **Use for**: 安全审计；处理认证/密钥/敏感数据；DevSecOps 集成
- **Triggers**: `PROACTIVELY` for security audits, DevSecOps, compliance
- **Model**: `opus`
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/full-stack-orchestration/agents/security-auditor.md)

#### `debugger`
Debugging specialist for errors, test failures, and unexpected behavior. The lst97 version (98 lines) — more detailed than wshobson's 33-line version.
- **Use for**: 任何 bug、test 失败、意外行为
- **Triggers**: `proactively` when encountering issues
- **Model**: `sonnet`
- **Source**: [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents/blob/main/agents/quality-testing/debugger.md)

#### `performance-engineer`
Modern observability + app optimization expert. OpenTelemetry, distributed tracing, load testing, multi-tier caching, Core Web Vitals, RUM, scalability patterns.
- **Use for**: 性能优化；可观测性；scalability 挑战；latency-critical 代码
- **Triggers**: `PROACTIVELY` for performance/observability/scalability
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/full-stack-orchestration/agents/performance-engineer.md)

#### `docs-architect`
Generates comprehensive technical documentation from existing codebases. Long-form manuals, architecture guides, technical deep-dives.
- **Use for**: 系统文档；架构指南；技术深度文章
- **Triggers**: `PROACTIVELY` for system documentation
- **Model**: `sonnet`
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/code-documentation/agents/docs-architect.md)

#### `tdd-orchestrator`
Master TDD orchestrator. Red-green-refactor discipline, multi-agent test workflow coordination, AI-assisted testing.
- **Use for**: TDD 实施 + governance；测试覆盖率提升
- **Triggers**: `PROACTIVELY` for TDD implementation
- **Model**: `opus`
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/tdd-workflows/agents/tdd-orchestrator.md)

#### `context-manager`
Elite AI context engineering specialist. Dynamic context management, vector DBs, knowledge graphs, intelligent memory systems for long-running multi-agent workflows.
- **Use for**: 复杂 AI orchestration；长会话上下文管理；多 agent 协调
- **Triggers**: `PROACTIVELY` for complex AI orchestration
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/agent-orchestration/agents/context-manager.md)

#### `sql-pro`
Modern SQL with cloud-native databases (OLTP/OLAP). Performance tuning, data modeling, hybrid analytical systems.
- **Use for**: SQL 优化；schema 设计；复杂分析查询
- **Triggers**: `PROACTIVELY` for database optimization
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/database-design/agents/sql-pro.md)

---

### 💻 Language (4)

#### `rust-pro`
Rust 1.75+ specialist with modern async patterns, advanced type system, production systems programming. Tokio, axum, cutting-edge crates.
- **Use for**: Rust 开发；性能优化；系统编程
- **Triggers**: `PROACTIVELY` for Rust development
- **Model**: `opus`
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/systems-programming/agents/rust-pro.md)

#### `typescript-pro`
TypeScript architect for Node.js and browser. Idiomatic code, complex type-level programming, performance tuning, large codebase refactoring.
- **Use for**: TS 架构设计；复杂类型编程；大规模重构
- **Triggers**: `PROACTIVELY` for TS architecture/refactoring
- **Model**: `sonnet`
- **Source**: [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents/blob/main/agents/development/typescript-pro.md)

#### `golang-pro`
Go 1.21+ master. Modern patterns, advanced concurrency, generics, workspaces, microservices, latest Go ecosystem.
- **Use for**: Go 开发；并发设计；微服务架构
- **Triggers**: `PROACTIVELY` for Go development
- **Model**: `opus`
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/systems-programming/agents/golang-pro.md)

#### `python-pro`
Python expert. Decorators, generators, async/await, design patterns, performance optimization, comprehensive test coverage.
- **Use for**: Python 重构 / 优化 / 复杂功能；量化研究 / 回测脚本
- **Triggers**: `PROACTIVELY` for Python refactoring/optimization
- **Model**: `sonnet`
- **Source**: [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents/blob/main/agents/development/python-pro.md)

---

### 🎨 Frontend (5)

#### `react-pro`
React expert. Component-based architecture, Hooks, Context API, state management, performance optimization.
- **Use for**: React 组件开发；重构；复杂 UI 挑战
- **Triggers**: `PROACTIVELY` for React development
- **Model**: `sonnet`
- **Source**: [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents/blob/main/agents/development/react-pro.md)

#### `vue-component-architect`
Vue 3 expert specializing in Composition API, scalable component architecture, modern Vue tooling.
- **Use for**: 设计或重构 Vue 组件、composables、应用级架构决策
- **Triggers**: `MUST BE USED` whenever working with Vue
- **Source**: [vijaythecoder/awesome-claude-agents](https://github.com/vijaythecoder/awesome-claude-agents/blob/main/agents/specialized/vue/vue-component-architect.md)

#### `electron-pro`
Cross-platform desktop apps with Electron + TypeScript. Secure IPC, native system integration, performant desktop UX.
- **Use for**: 新建 Electron 应用 / 重构 / 桌面专属功能
- **Triggers**: `PROACTIVELY` for Electron development
- **Model**: `sonnet`
- **Source**: [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents/blob/main/agents/development/electorn-pro.md)
- ⚠️ **Note**: 上游文件名拼写错为 `electorn-pro.md` (electorn 而非 electron)

#### `nextjs-pro`
Next.js expert. SSR/SSG/App Router, performance, SEO, modern testing.
- **Use for**: 新建 Next.js 项目 / 性能优化 / 复杂功能实现
- **Triggers**: `PROACTIVELY` for Next.js architecture
- **Model**: `sonnet`
- **Source**: [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents/blob/main/agents/development/nextjs-pro.md)

#### `ux-designer`
User research → final implementation. Empathy-driven UX advocate, accessibility, usability, visual design.
- **Use for**: UI/UX 设计；可访问性；用户旅程
- **Triggers**: `PROACTIVELY` to advocate user needs
- **Model**: `sonnet`
- **Source**: [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents/blob/main/agents/development/ux-designer.md)

---

### 🤖 Automation (1)

#### `playwright-expert`
Playwright TS testing for modern web apps. Robust, reliable, maintainable test suites.
- **Use for**: E2E 测试；浏览器自动化；CI 集成
- **Triggers**: 任何 Playwright 任务
- **Source**: [0xfurai/claude-code-subagents](https://github.com/0xfurai/claude-code-subagents/blob/main/agents/playwright-expert.md)

---

### 📡 API (1)

#### `exchange-api-integrator` ⭐ **custom**
Crypto exchange API integration specialist (Binance / Bybit / OKX / Polymarket). HMAC signing, listenKey/private channel auth, orderbook depth streams, rate limits, error code recovery.
- **Use for**: 调任何交易所 API；订阅行情；下单；构建统一交易客户端
- **Triggers**: `PROACTIVELY` for exchange API tasks; **testnet first, mainnet only with explicit confirmation**
- **Model**: `opus`
- **Why custom**: 6 个上游 repo 全部缺失 CEX/Polymarket 专用 agent
- **Example**: *"在 Binance 跑一个网格策略"* → agent 先 fetch 官方 docs + 实现 HMAC 签名 + 测试网验证

---

### ⛓️ Blockchain (2)

#### `blockchain-developer`
Production Web3 apps + smart contracts + decentralized systems. DeFi protocols, NFT, DAOs, EVM, Solidity, account abstraction, L2.
- **Use for**: 智能合约；Web3 dApp；DeFi 协议；EVM 链
- **Triggers**: `PROACTIVELY` for smart contracts/Web3
- **Model**: `opus`
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/blockchain-web3/agents/blockchain-developer.md)

#### `btc-brc20-specialist` ⭐ **custom**
BTC L1 + Ordinals theory + BRC-20 protocol. Commit-reveal Taproot scripts, ord-rs/ord toolchain, UniSat/OKX/Magic Eden APIs, mempool.space.
- **Use for**: BTC inscriptions；BRC-20 deploy/mint/transfer；satoshi 追踪；BTC L1 fee 估算
- **Triggers**: `PROACTIVELY` for BTC L1 / Ordinals / BRC-20
- **Model**: `opus`
- **Why custom**: 6 个上游 repo **零** BTC L1 / Ordinals 覆盖
- **Example**: *"deploy BRC-20 token TEST"* → 自动验证 tick uniqueness + 设计 commit-reveal + 估 fee + 等用户硬件钱包签名

---

### 🛠️ Custom Ops (2)

#### `pmbotv8-vps-ops` ⭐ **custom**
Trading bot VPS operations specialist. Manages systemd units, deploys via scp, queries journalctl logs, runs cron-driven reconciliation, inspects SQLite state. Strictly enforces **"active=0 before restart"** and **"private key never leaves .env"**.
- **Use for**: pmbotv8 部署/调试/重启/对账/生产状态检查
- **Triggers**: `PROACTIVELY` for any pmbotv8 ops task
- **Model**: `sonnet`
- **Why custom**: 私有项目专用 agent；可作为他人交易机器人 ops 的模板
- **Note for forkers**: 替换 `<YOUR_VPS_IP>` 等占位符为你自己的环境

#### `web-reverse-engineer` ⭐ **custom**
Web HTTP API reverse engineering. Chrome DevTools / mitmproxy capture, curl 复刻, JS bundle 反混淆, signing/auth 算法追踪, undocumented API 文档化。
- **Use for**: "搞清楚 X 网站的 API 怎么用"；"复刻这个 XHR 请求"；"反混淆这个 minified 包"
- **Triggers**: `PROACTIVELY` for web API RE; **strictly authorized targets only**
- **Model**: `opus`
- **Why custom**: wshobson 的 `reverse-engineer` 偏二进制 RE (IDA/Ghidra)，与 web HTTP 方向不重合
- **Example**: *"复刻交易所 X 的 web 下单逻辑"* → DevTools 抓包 → 找到 X-Sign header → 反混淆签名函数 → 写出 Python 客户端

---

### 📊 Domain (1)

#### `quant-analyst`
Quantitative finance + algorithmic trading specialist. Financial models, backtest, risk metrics, portfolio optimization, statistical arbitrage. Includes pairs trading + Sharpe + 含手续费/滑点的回测。
- **Use for**: 量化策略；交易算法；风险分析
- **Triggers**: `PROACTIVELY` for quantitative finance / trading
- **Source**: [wshobson/agents](https://github.com/wshobson/agents/blob/main/plugins/quantitative-trading/agents/quant-analyst.md)

---

## Install

### Option A: clone + install (recommended)

```bash
git clone https://github.com/liboheng/claude-agents-toolkit.git
cd claude-agents-toolkit
bash install.sh
```

### Option B: one-liner (after fork)

```bash
curl -fsSL https://raw.githubusercontent.com/liboheng/claude-agents-toolkit/main/install.sh | bash
```

The installer copies `agents/**/*.md` into `~/.claude/agents/`, preserving subdirectory structure. Existing agents are backed up to `~/.claude/agents.backup.<timestamp>/`.

> 🇨🇳 **China users**: if `raw.githubusercontent.com` is slow, install via clone (Option A) using a proxy (Surge/Clash on `:7890`), or replace `raw.githubusercontent.com` with `cdn.jsdelivr.net/gh/...` in the script.

---

## Usage examples

See [`docs/usage-examples.md`](docs/usage-examples.md) for four end-to-end walkthroughs:

1. **Building a dApp** (Solidity + React + viem) — orchestrator routes through `blockchain-developer` → `react-pro` → `code-reviewer`
2. **Debugging pmbotv8 reconcile drift** — `pmbotv8-vps-ops` → `exchange-api-integrator` → `code-reviewer`
3. **Reverse engineering an exchange web API** — `web-reverse-engineer` → `exchange-api-integrator` → `playwright-expert`
4. **BTC BRC-20 deploy + mint** — `btc-brc20-specialist` 单 agent 完成 commit-reveal + 多 indexer 验证

---

## Architecture choices

**Why subdirectories instead of flat?** With 25 agents, `ls ~/.claude/agents/` gets unwieldy. Subdirectories (`orchestrator/`, `common/`, `language/`, `frontend/`, `automation/`, `api/`, `blockchain/`, `custom/`, `domain/`) make discovery natural. Claude Code's recursive scanner handles this.

**Why an orchestrator?** Multi-stack work (e.g., dApp = Solidity + React + viem + tests) means manually picking 3-4 agents per task. `tech-lead-orchestrator` does the routing, you stay focused.

**Why mix sources?** No single repo covers everything well. We picked the **best-of-breed per domain** rather than blindly using one author. The selection rationale (6-repo comparison) lives in our commit history.

---

## Updating

To pull upstream changes:

```bash
cd claude-agents-toolkit
git pull
bash install.sh   # idempotent — re-runs safely, backs up old version
```

Customized an agent locally? The backup at `~/.claude/agents.backup.<timestamp>/` preserves your version.

---

## Forking for your own use

If you fork this repo:
1. **Replace placeholders** in `agents/custom/pmbotv8-vps-ops.md`:
   - `<YOUR_VPS_IP>` → your actual VPS IP
   - `<BASELINE_TIMESTAMP_UTC>` and `<BASELINE_PUSD>` → your reconcile baseline
2. **Rename** `pmbotv8-vps-ops.md` to `<your-bot-name>-vps-ops.md` (and update frontmatter `name:`)
3. **Customize** `agents/custom/` with your project-specific agents
4. **Update README** Credits / Inventory to reflect your changes

---

## Contributing

Pull requests welcome for:
- New custom agents that fill gaps (especially crypto-native domains)
- Bumping upstream agents to newer versions
- Real-world usage examples to add to `docs/usage-examples.md`

Please **don't** submit:
- Framework specialists already well-covered upstream (just link to upstream)
- Agents bundled with auto-execute hooks (security review burden)

---

## License

MIT — see [LICENSE](LICENSE).

---

## Credits

This toolkit stands on the shoulders of these excellent upstream projects:

| Repo | Contribution |
|---|---|
| [wshobson/agents](https://github.com/wshobson/agents) | Most common/language/blockchain/quant agents |
| [vijaythecoder/awesome-claude-agents](https://github.com/vijaythecoder/awesome-claude-agents) | tech-lead-orchestrator, code-reviewer, vue-component-architect |
| [lst97/claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents) | debugger (detailed version), TS/Python/React/Electron/Next.js/UX |
| [0xfurai/claude-code-subagents](https://github.com/0xfurai/claude-code-subagents) | playwright-expert |
| [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | Reference for selection |
| [supatest-ai/claude-code-subagents](https://github.com/supatest-ai/claude-code-subagents) | Reference for selection |

All upstream agents retain their original licenses. The 4 custom agents (`btc-brc20-specialist`, `exchange-api-integrator`, `web-reverse-engineer`, `pmbotv8-vps-ops`) are MIT.

---

*Last updated: 2026-05-04*
