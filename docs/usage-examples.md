# Usage Examples

Three real-world walkthroughs showing how `tech-lead-orchestrator` routes work
across the toolkit's specialist agents.

---

## Example 1 — Build a dApp: Solidity contract + React frontend + viem

**User prompt:**

> "I want a simple staking dApp on Base. Solidity contract that lets users
> stake an ERC-20 and earn 5% APY, React frontend with viem, deploy with
> hardhat, full test coverage."

**Orchestration:**

1. `tech-lead-orchestrator` analyzes scope → identifies stack (Solidity + React + Web3).
2. Delegates to `blockchain-developer` for the staking contract → outputs `Staking.sol` + hardhat tests + deploy script.
3. Delegates to `react-pro` for the frontend → wires up viem contract calls, wallet connect, stake/unstake UI.
4. Delegates to `code-reviewer` for security pass on Solidity (reentrancy, access control, overflow on rewards).
5. Optionally invokes `playwright-expert` for E2E test against a local Anvil fork.

**Final deliverables:**
- `contracts/Staking.sol` + `test/Staking.t.sol` (100% coverage)
- `src/components/StakingPanel.tsx` with viem hooks
- `scripts/deploy-base-sepolia.ts`
- Code review report with severity-ranked findings

---

## Example 2 — Debug pmbotv8 reconcile drift

**User prompt:**

> "Reconcile shows -3 share drift on market 0xabc... since 14:00 UTC. Bot is
> still running. What happened and how do I fix it?"

**Orchestration:**

1. `tech-lead-orchestrator` recognizes pmbotv8 keyword → routes to `pmbotv8-vps-ops` as primary.
2. `pmbotv8-vps-ops` runs the standard pre-flight: `systemctl status` (still active), reads `reconciliation.csv` for the affected market, queries `pmbotv8-live.db` for orders/fills since 13:30 UTC, pulls `journalctl` errors.
3. Identifies a `429 Rate Limit` cluster at 13:58 UTC followed by 3 missed fill confirmations → hands off to `exchange-api-integrator` for Polymarket-side investigation.
4. `exchange-api-integrator` re-queries Polymarket positions API directly to confirm on-chain truth; computes exact drift; proposes a code patch to improve fill polling on rate-limit recovery.
5. `code-reviewer` validates the patch (no new race conditions, decimal handling correct).
6. `pmbotv8-vps-ops` walks through deploy: build local → scp → wait for `active=0` → restart → verify next reconcile cycle clean.

**Final deliverables:**
- Root-cause writeup in `docs/debug-reports/2026-05-04-drift-incident.md`
- Patch to fill-polling logic with regression test
- Verified clean reconcile in `reconciliation.csv`

---

## Example 3 — Reverse engineer an exchange web API for automation

**User prompt:**

> "Exchange X has a web UI for limit orders but no public API. I have a paid
> account. I want a Python client that places orders the same way the web does."

**Orchestration:**

1. `tech-lead-orchestrator` confirms authorization (user owns the account) → routes to `web-reverse-engineer` as primary.
2. `web-reverse-engineer` walks the user through DevTools capture: place a single test limit order → export HAR → identify the `POST /v1/orders` request → trace the `X-Sign` header back to a webpack module → deobfuscate the signing function (HMAC-SHA256 over canonical JSON).
3. Hands off to `exchange-api-integrator` to build the production client: typed Python wrapper, env-based credentials, rate-limit aware, testnet variant if available.
4. `code-reviewer` checks no secrets are logged, error handling covers all observed status codes, decimal types used for price/qty.
5. `playwright-expert` (optional) writes a Playwright test that exercises the web UI flow end-to-end so future API changes can be detected automatically.

**Final deliverables:**
- `docs/exchange-x-api.md` — endpoint table + auth algorithm writeup
- `clients/exchange_x/` — typed Python client with tests
- `e2e/exchange_x_smoke.spec.ts` — Playwright sentinel for upstream changes

---

## Bonus: BTC BRC-20 mint flow

**User prompt:**

> "Help me deploy a BRC-20 token called TEST with max=21M, lim=1000, then mint
> 1000 to my UniSat wallet."

**Orchestration:**

1. `tech-lead-orchestrator` routes to `btc-brc20-specialist` (single-agent task).
2. `btc-brc20-specialist` fetches `mempool.space/api/v1/fees/recommended` → suggests current sat/vB.
3. **Refuses to default to mainnet** — asks user to confirm signet/testnet4/mainnet.
4. On mainnet confirmation: validates `TEST` tick uniqueness via UniSat API → designs commit-reveal Taproot tx pair → constructs unsigned PSBTs → hands to user for hardware wallet signing.
5. After broadcast: monitors via mempool.space WSS → waits 1 confirmation on commit → broadcasts reveal → after 1 confirmation on reveal, calls UniSat + Hiro APIs to verify token registered.
6. For mint: same commit-reveal pattern with `op:"mint"` + `amt:"1000"` payload.

**Final deliverables:**
- Signed and confirmed deploy + mint inscriptions
- Verification report (cross-checked UniSat + Hiro)
- Reusable mint script for future batches
