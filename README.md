# 流光AI GEO 卫星站

静态 GitHub Pages：用**少而精**的高意图落地页承接模型/工具搜索词，软链回 [liuguang.ai](https://liuguang.ai/)，**不改主站代码**。

品牌消歧：**流光AI（liuguang.ai，多模型助手与创作平台）**。

## 页面一览

| 路径 | 意图 |
| --- | --- |
| `index.html` | 枢纽索引 |
| `claude-api/` | Claude API |
| `openai-compatible/` | OpenAI 兼容 base_url |
| `cursor-api/` | Cursor 自定义 API |
| `gpt-api/` | GPT API |
| `deepseek-api/` | DeepSeek API |
| `gemini-api/` | Gemini API |
| `kimi-api/` | Kimi API |
| `glm-api/` | GLM / 智谱 API |
| `midjourney/` | Midjourney / AI 绘画（网页） |
| `kling-api/` | 可灵 / AI 视频（网页） |
| `outreach/` | 站外引流文案草稿（勿当网页发布） |

接口事实：

- Base URL（OpenAI 兼容）：`https://liuguang.ai/v1`
- 密钥前缀：`sk-lg-`
- Claude Code：站点根（不带 `/v1`），以 [docs](https://liuguang.ai/docs) 为准
- 文档 / 价格 / 指南：`/docs` `/pricing` `/guide`

## GitHub Pages

仓库：https://github.com/liuguangaiai/liuguang-geo-satellites  
线上（自定义域）：https://geo.liuguang.ai/  
旧址（配置成功后由 Pages 自动 301）：https://liuguangaiai.github.io/liuguang-geo-satellites/

Settings → Pages → Deploy from branch → `main` / `(root)`；Custom domain = `geo.liuguang.ai`（根目录 `CNAME` 已提交）。  
DNS（用户在 name.com）：`CNAME geo → liuguangaiai.github.io`。DNS 未生效前 `geo.` 不可访问；HTTPS Enforce 需等证书签发。

## 上线后

1. GSC / Bing / 百度验证后提交本仓库 `sitemap.xml`
2. 执行 `./indexnow.sh`（Bing IndexNow）
3. 用 `outreach/` 草稿发知乎 / linux.do 等站外引用（比刷蜘蛛更稳）

## 新增词页

复制现有目录 → 重写独立正文与 FAQ → 更新 `index.html`、`sitemap.xml`、`indexnow.sh` → 推送 → 再跑 IndexNow。禁止换词复制。

## 风险

批量薄页有 doorway 风险。策略是**独立有用内容 + 官方提索引 + 站外真实外链**，不做蜘蛛池。


## 新增高意图页（第二批）

- `claude-code-api/` — Claude Code API
- `cursor-claude/` — Cursor 接入 Claude
- `openai-base-url/` — OpenAI Base URL
- `chatgpt-api-cn/` — ChatGPT API 国内
- `deepseek-compatible/` — DeepSeek 兼容
- `multi-model-api/` — 多模型 API 聚合
- `grok-api/` — Grok API
- `suno-api/` — Suno / AI 音乐
- `runway-api/` — Runway / AI 视频
- `liuguang-tutorial/` — 流光AI 教程中心
