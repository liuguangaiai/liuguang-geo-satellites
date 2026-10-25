# GEO 卫星站迁入 liuguang.ai 权威域 — 执行计划

**日期：** 2026-10-25（Asia/Shanghai）  
**现状：** 卫星站在孤儿 `liuguangaiai.github.io/liuguang-geo-satellites/`，页面 HTTP 200，但 Google/Bing `site:` 仍无收录 → 无搜索流量。  
**目标：** 把钱页挂到 `liuguang.ai` 权威下，打通发现门槛，再谈内容排序。

---

## 0. 默认推荐（本计划拍板）

### **推荐默认：`geo.liuguang.ai`（GitHub Pages 自定义子域）**

| 方案 | 能否不改主站代码立刻上线 | 权威 | 风险 | 结论 |
| --- | --- | --- | --- | --- |
| **A. `geo.liuguang.ai` → Pages** | **能**（只动 DNS + 本仓库） | 同 apex，远强于裸 github.io | 低；与主站 Next 解耦 | **默认走这条** |
| B. `liuguang.ai/blog/...` | **不能**（主站 Next.js，`/blog` 现 404；本机无主站源码） | 最强（同 host） | 需改生产路由/发布流 | 中期目标，不挡本周 |
| C. Cloudflare Pages/Workers 挂同域 | 需 CF 账号与改 DNS | 强 | 比 A 多一次平台迁移 | 备选 |

**为何不先 `/blog`：**  
主站探测结果：`https://liuguang.ai/` 为 Next.js（nginx + RSC headers）；`/docs` `/guide` `/pricing` = 200；**`/blog` `/geo` `/tutorials` = 404**。  
本 box **没有**主站仓库 checkout（仅有 `/workspace/liuguang-geo-satellites`）。往 `/blog` 塞静态页必须改主站并走生产发布，和本仓库「不改主站代码」设计冲突，无法本周闭环。

**为何 `geo.` 够用：**  
研究结论是「发现/权威断了」不是「GEO 概念废了」。同注册人子域 + GSC 验证 + 官方 sitemap，足以跨过收录门槛；路径形态仍是现有静态站，仓库零架构重写。

---

## 1. 目标架构（默认 A）

```
用户 / 爬虫
    │
    ▼
https://geo.liuguang.ai/claude-api/     ← 新 canonical（Pages 根路径，无 /repo 前缀）
    │
    │  CNAME geo → liuguangaiai.github.io
    ▼
GitHub Pages ← 本仓库 main/(root)
    │
    └── CTA / 文档仍链回 https://liuguang.ai/ 、/docs 、/v1
```

旧址：

```
https://liuguangaiai.github.io/liuguang-geo-satellites/...
  →（Pages 自定义域开启后）自动 301 到 https://geo.liuguang.ai/...
```

DNS 现状（2026-10-25 公网查询）：

- apex `liuguang.ai` A → `43.163.251.132`
- NS → `name.com`（`ns1cnb` / `ns2dfg` / `ns3cna` / `ns4bty.name.com`）
- **`geo.liuguang.ai` 尚不存在（NXDOMAIN）** — 需用户在 name.com 加记录

---

## 2. 精确 DNS / CNAME 步骤（`geo.liuguang.ai`）

> 顺序很重要：先在 GitHub 填自定义域，再写 DNS，降低子域被抢注风险。  
> 官方文档：[Managing a custom domain for GitHub Pages](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)

### 2.1 仓库侧（我们可做 / 可指导操作）

1. 打开 https://github.com/liuguangaiai/liuguang-geo-satellites → **Settings → Pages**
2. **Custom domain** 填：`geo.liuguang.ai` → **Save**  
   - 从 branch 发布时，GitHub 会在源分支根目录提交 `CNAME` 文件，内容一行：`geo.liuguang.ai`
3. 勾选 **Enforce HTTPS**（DNS 生效、证书签发后才可勾；通常数分钟～数小时）
4. （可选但推荐）在 GitHub Org/User 设置里 **Verify** `liuguang.ai`，防子域接管

本仓库也可预先提交根文件 `CNAME`：

```
geo.liuguang.ai
```

### 2.2 DNS 侧（**必须用户 / 有 name.com 权限的人**）

登录 **name.com**（当前 NS 指向此处），为 `liuguang.ai` 添加：

| Type | Host / Name | Value / Answer | TTL |
| --- | --- | --- | --- |
| **CNAME** | `geo` | `liuguangaiai.github.io` | 300–3600 |

要点：

- CNAME **目标不要**带仓库名（不是 `…github.io/liuguang-geo-satellites`）
- **不要**用 `*.liuguang.ai` 通配（GitHub 明确警告接管风险）
- 不要同时再给 `geo` 加 A/AAAA（CNAME 与其它记录冲突）
- 传播通常 &lt; 1h，最长可到 24h

### 2.3 验收命令

```bash
# 应看到 CNAME → liuguangaiai.github.io
dig +short geo.liuguang.ai CNAME
# 或
curl -sI https://geo.liuguang.ai/ | head -20   # 期望 200 + Pages
curl -sI https://liuguangaiai.github.io/liuguang-geo-satellites/ | head -20
# 期望 301 Location: https://geo.liuguang.ai/
```

### 2.4 Cloudflare 备选（仅当用户把 NS 迁到 CF 时）

若日后 NS 改到 Cloudflare：

1. CF DNS：`geo` CNAME → `liuguangaiai.github.io`，Proxy 建议先 **DNS only（灰云）**，等 GitHub 证书签发后再考虑橙云  
2. 或改托管到 Cloudflare Pages，绑定同主机名 — 属于另一次迁移，**本周不默认**

---

## 3. 优先迁的 5–8 个最高意图页

先迁这些（与产品转化 + 已发知乎选题对齐）；其余批次二再跟。

| # | 路径（现 / 新） | 意图 | 优先理由 |
| --- | --- | --- | --- |
| 1 | `openai-base-url/` | OpenAI base_url 填什么 | 知乎已发文；开发者刚需词 |
| 2 | `openai-compatible/` | OpenAI 兼容替换 | 全站共性入口 |
| 3 | `cursor-api/` | Cursor 自定义 API | IDE 高转化 |
| 4 | `cursor-claude/` | Cursor × Claude | 第二波知乎同题 |
| 5 | `claude-code-api/` | Claude Code（不带 /v1） | 易配错，差异化强 |
| 6 | `chatgpt-api-cn/` | 国内 ChatGPT API | 中文高意图 |
| 7 | `multi-model-api/` | 多模型聚合怎么选 | 知乎专栏同题 |
| 8 | `claude-api/` | Claude API 接入 | 品牌核心模型词 |

枢纽页同步更新：`index.html`、`liuguang-tutorial/`（导航/内链，不单独当钱页 KPI）。

批次二（域名通了再刷）：`gpt-api` `deepseek-api` `deepseek-compatible` `gemini-api` `kimi-api` `glm-api` `grok-api` `midjourney` `kling-api` `suno-api` `runway-api`。

新 URL 形态（注意：**无** `/liuguang-geo-satellites` 前缀）：

```
https://geo.liuguang.ai/openai-base-url/
https://geo.liuguang.ai/cursor-api/
…
```

---

## 4. Canonical + 301 策略

### 4.1 301（旧 → 新）

| 从 | 到 | 谁负责 |
| --- | --- | --- |
| `https://liuguangaiai.github.io/liuguang-geo-satellites/` | `https://geo.liuguang.ai/` | **GitHub Pages 自定义域自动 301**（配置成功后） |
| `…/liuguang-geo-satellites/<slug>/` | `https://geo.liuguang.ai/<slug>/` | 同上（路径去掉 repo 名） |

验收：对首页 + 上表 8 页各打一次 `curl -sI`，确认 `301` 且 `Location` 正确。

若个别爬虫仍缓存旧 URL：保留 github.io 仓库与 Pages **不要删**，至少 90 天；301 是信号传递通道。

### 4.2 Canonical / 站内 URL 全量改写（本仓库可立刻做）

对 **全部** HTML / `sitemap.xml` / `robots.txt` / `indexnow.sh` / JSON-LD / `og:url`：

| 字段 | 旧 | 新 |
| --- | --- | --- |
| `link rel=canonical` | `https://liuguangaiai.github.io/liuguang-geo-satellites/...` | `https://geo.liuguang.ai/...` |
| `og:url` / WebSite `url` | 同上 | 同上 |
| `sitemap <loc>` | 同上 | 同上 |
| `robots Sitemap:` | 旧 sitemap | `https://geo.liuguang.ai/sitemap.xml` |
| IndexNow 提交列表 | 旧 URL | 新 URL |
| 站内绝对链接（若有） | 含 github.io 的 | 改相对或 geo. |

**禁止**新旧双 canonical；钱页只宣告 `geo.liuguang.ai`。

### 4.3 站长工具（域名通了立刻做）

1. Google Search Console：添加资源 `https://geo.liuguang.ai/`，DNS TXT 或 HTML 验证 → 提交 sitemap → 对 8 个优先页 **请求编入索引**  
2. Bing Webmaster：同样验证 + sitemap；再跑一次 IndexNow（Bing 吃；**Google 不吃 IndexNow**）  
3. （可选）百度站长：中文流量相关时再加

### 4.4 外链

知乎等已发链接若仍指向 github.io：能改则改成 `geo.`；改不了的靠 301 接力，不批量删帖。

---

## 5. 分工：父代理必须找用户的 vs 仓库现在就能做的

### 5.1 必须用户（或持有凭证的人）配合 — **仅 DNS / 站长验证类**

父代理应向用户要的具体动作（不要问开放式问题，直接给清单）：

1. **name.com 登录**，为 `liuguang.ai` 添加：  
   `CNAME  geo  →  liuguangaiai.github.io`
2. （推荐）把 GSC / Bing 验证码交给我们填，或用户自己完成 `geo.liuguang.ai` 资源验证  
3. 若 GitHub 仓库 Settings 我们无权限：用户在 Pages 里填 Custom domain = `geo.liuguang.ai` 并 Enforce HTTPS  
4. **不要**在未确认前改 apex A 记录或 NS（主站 `43.163.251.132` 必须保持不动）

### 5.2 本仓库 / 执行代理现在就能做（无需等 DNS 也可准备）

- [x] 写本计划 `MIGRATION-PLAN.md`
- [x] 添加根文件 `CNAME`（`geo.liuguang.ai`）
- [x] 批量改写 canonical / og / sitemap / robots / indexnow / JSON-LD 到 `https://geo.liuguang.ai/...`
- [x] README 更新线上地址与迁移说明
- [ ] DNS 生效后：跑验收 curl、IndexNow、协助 GSC「请求编入索引」
- [ ] 知乎新帖改为链 `geo.`；旧帖能编则编

### 5.3 明确不做（本阶段）

- 不改主站 Next 生产代码、不强行造 `/blog`（无本地主站 checkout）
- 不做蜘蛛池 / 站群 / 黑帽「当天收录」
- 不删 github.io 源站（需保留 301）
- 不把 `geo` 橙云代理到 CF，直到 GitHub HTTPS 稳定

---

## 6. 主站本地源码检查结果

| 项 | 结果 |
| --- | --- |
| `/workspace` 下 liuguang 相关 | **仅** `liuguang-geo-satellites` |
| 主站 Next.js checkout | **未找到** |
| `https://liuguang.ai/blog` | **404** |
| 主站已有内容路径 | `/docs` `/guide` `/pricing` = 200 |

→ **本周无法**在不碰生产的前提下把钱页塞进 `liuguang.ai/blog`。中期若拿到主站 repo，可再评估把 `geo.` 301 并入 `/blog` 或 `/docs/geo/`；那是第二阶段，不阻塞本计划。

---

## 7. 执行顺序（建议父代理下一拍）

1. **现在（仓库）：** 提交 `CNAME` + URL 全量改写到 `geo.liuguang.ai`（即使 DNS 未好，HTML 已对齐最终 canonical）  
2. **并行找用户：** name.com 加 CNAME；GitHub Pages 填自定义域  
3. **DNS 绿了：** Enforce HTTPS → 验 301 → GSC/Bing 验证 + sitemap + 8 页请求索引  
4. **14 天测量：** GSC「已编入索引」页数；若仍 0，再判内容/质量问题，而不是发现断了

---

## 8. 成功标准（可证伪）

| 时间窗 | 信号 |
| --- | --- |
| DNS 后 48h | `geo.liuguang.ai` 200；github.io → geo 301；HTTPS 锁 |
| 7 天 | GSC 至少看到抓取或「已发现」；Bing 有 URL |
| 14 天 | 优先 8 页中 ≥3 页「已编入索引」或有展示次数；否则升级复盘（内容/外链），而非再堆卫星页 |

---

**一句话：** 默认迁到 **`geo.liuguang.ai`**；`/blog` 留到有主站源码再说。用户只需在 name.com 加一条 CNAME，其余改仓库即可推进。
