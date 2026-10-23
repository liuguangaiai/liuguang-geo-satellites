# 流光AI GEO 卫星站模板

静态 GitHub Pages 站点：用**少而精**的高意图落地页承接「Claude API / OpenAI 兼容 / Cursor base_url」等搜索，再软链回官网 [liuguang.ai](https://liuguang.ai/)，**不改动主站代码**。

品牌消歧请统一写：**流光AI（liuguang.ai，多模型助手与创作平台）**。

## 本仓库是什么

| 路径 | 说明 |
| --- | --- |
| `index.html` | 枢纽页：品牌说明 + 落地页索引 + CTA |
| `claude-api/` | Claude API 接入（经流光AI OpenAI 兼容端点） |
| `openai-compatible/` | base_url 替换 / SDK 兼容教程 |
| `cursor-api/` | Cursor（及同类 IDE）自定义 OpenAI Base URL |
| `assets/styles.css` | 轻量样式，无构建步骤 |
| `robots.txt` / `sitemap.xml` | 爬虫与站点地图 |

接口事实以官网为准：

- Base URL（OpenAI 兼容）：`https://liuguang.ai/v1`
- 密钥前缀：`sk-lg-`
- 文档：https://liuguang.ai/docs
- 价格：https://liuguang.ai/pricing
- 指南：https://liuguang.ai/guide

本模板**不写具体单价、不虚构测评、不宣称第一**。模型 ID 请用户从模型市场或 `GET /v1/models` 复制。

## 如何启用 GitHub Pages

1. 新建 GitHub 仓库（建议名：`liuguang-geo-satellites`），把本目录全部文件推到默认分支（如 `main`）。
2. 打开仓库 **Settings → Pages**。
3. **Build and deployment → Source** 选 **Deploy from a branch**。
4. Branch 选 `main`，文件夹选 `/ (root)`，保存。
5. 等待一两分钟，访问：  
   `https://<你的用户名>.github.io/liuguang-geo-satellites/`

若使用 `username.github.io` 用户站仓库，则站点根路径不同，请同步改 sitemap / canonical（见下节）。

## 必须替换的占位符

全文统一占位：

```text
liuguangaiai
```

以及完整站点根：

```text
https://liuguangaiai.github.io/liuguang-geo-satellites
```

请在以下文件中**全部替换**为你的真实用户名与仓库名（若仓库名不同，两处一起改）：

- `sitemap.xml`（`<loc>`）
- `robots.txt`（`Sitemap:`）
- 各页 `<link rel="canonical">` 与 Open Graph / JSON-LD 里的 URL  
  （`index.html`、`claude-api/index.html`、`openai-compatible/index.html`、`cursor-api/index.html`）

示例（macOS / Linux）：

```bash
# 在仓库根目录执行；把 yourname 换成你的 GitHub 用户名
find . -type f \( -name '*.html' -o -name 'sitemap.xml' -o -name 'robots.txt' \) \
  -exec sed -i 's/liuguangaiai/yourname/g' {} +
```

本地预览（任意静态服务器均可）：

```bash
cd liuguang-geo-satellites
python3 -m http.server 8080
# 浏览器打开 http://127.0.0.1:8080/
```

## 上线后建议

1. 在 [Google Search Console](https://search.google.com/search-console) 添加该 GitHub Pages 属性，提交 `sitemap.xml`。
2. Bing Webmaster 同样提交 sitemap。
3. 用「网址检查」抽测首页与三个落地页是否可索引。
4. **先观察 1–2 周收录与点击**，再考虑加第 4、第 5 个词；不要一次铺几十个同模板薄页（doorway 风险）。

## 如何新增一个关键词页

1. 复制现有目录，例如：  
   `cp -R openai-compatible deepseek-api`
2. 重写该页的：
   - `<title>`、meta description、H1（对准真实搜索意图）
   - 正文（独立角度，500–900 字有效信息，禁止复制粘贴改词）
   - FAQ / JSON-LD（问题必须本页独有）
   - canonical 与 OG URL（指向新路径）
3. 在 `index.html` 卡片区加入口链接。
4. 在 `sitemap.xml` 增加一条 `<url>`。
5. 互相加 1–2 条「相关教程」内链。
6. 推送后到 GSC 请求编入索引。

### 新页内容清单（发布前勾选）

- [ ] 文首有品牌消歧「流光AI（liuguang.ai，多模型助手与创作平台）」
- [ ] 未编造价格 / 模型数量 /「第一」话术
- [ ] base_url、密钥前缀与官网文档一致；不确定处写「以 https://liuguang.ai/docs 为准」
- [ ] CTA 指向官网注册、`/docs`、`/pricing`
- [ ] canonical 指向**本卫星页**自己的 URL（不要全部指回主站，否则卫星页难收录）
- [ ] 与已有三页角度明显不同

## 风险提醒（请认真看）

- `*.github.io` **有一定信任基础，但不是 SEO 权重外挂**。批量关键词薄页容易被判为 doorway pages。
- 正确策略：**3–5 个真有意图的深度短页 → 验证收录 → 再扩**。
- 卫星站是补充；Search Console、知乎/目录、可引用长文对 GEO 往往同样重要。
- 密钥示例中的 `sk-lg-你的密钥` 仅为占位，**永远不要把真实密钥写进仓库**。

## 许可与归属

教程文案面向推广流光AI（liuguang.ai）。产品商标与主站内容归属官方；本模板可按需修改后自用。推送前请自行确认合规与品牌表述。

## IndexNow（Bing 加速收录）

仓库根目录有 `1fa345f831c1bfd4004a472542fcaf23.txt`（密钥文件，勿删）。上线后在本机执行：

```bash
./indexnow.sh
```

或设置 `INDEXNOW_KEY=1fa345f831c1bfd4004a472542fcaf23` 后执行。
