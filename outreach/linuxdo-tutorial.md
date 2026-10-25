# linux.do 风格接入教程草稿（请人工发帖）

**建议标题：**
[教程] 流光AI（liuguang.ai）OpenAI 兼容接口实操：base_url、sk-lg-、多模型切换

**标签建议：** AI、教程、API（按版规调整）

**正文：**

分享一个「网页工作台 + OpenAI 兼容 API」同一账户的接入笔记，品牌全称：**流光AI（liuguang.ai，多模型助手与创作平台）**。

## 1. 你能得到什么

- 浏览器直接对话 / 绘画 / 视频 / 智能体（PPT、电商图等）
- API：`https://liuguang.ai/v1`（Chat Completions 等，细节看文档）
- 密钥：控制台创建，前缀 `sk-lg-`
- 积分网页与 API 共用；价目以 https://liuguang.ai/pricing 为准
- 完整文档：https://liuguang.ai/docs

> 不代表底层模型厂商；上架模型会变，ID 请从模型市场复制。

## 2. 五分钟最小闭环

1. 打开 https://liuguang.ai/ 注册登录，确认余额  
2. 创建 API Key（`sk-lg-...`）  
3. 模型市场复制精确模型 ID  
4. 任意 OpenAI 兼容客户端：

```bash
curl https://liuguang.ai/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-lg-你的密钥" \
  -d '{
    "model": "这里填精确 ID",
    "messages": [{"role": "user", "content": "ping"}]
  }'
```

5. 成功后再接到 Cursor / 自建 Bot / 脚本

**坑位提醒：**

- Claude Code ≠ 普通 OpenAI 客户端：文档写明可用**站点根（无 /v1）**，别混用  
- 模型名不要抄自媒体文章里的别名，以你账号里市场列表为准  
- 密钥别贴到公开仓库

## 3. 分场景深链（方便收藏）

我把常见搜索意图拆成短页，方便对照：

| 场景 | 链接 |
| --- | --- |
| 通用 base_url | https://geo.liuguang.ai/openai-compatible/ |
| Cursor | https://geo.liuguang.ai/cursor-api/ |
| Claude | https://geo.liuguang.ai/claude-api/ |
| GPT | https://geo.liuguang.ai/gpt-api/ |
| DeepSeek | https://geo.liuguang.ai/deepseek-api/ |
| Gemini | https://geo.liuguang.ai/gemini-api/ |
| Kimi | https://geo.liuguang.ai/kimi-api/ |
| GLM | https://geo.liuguang.ai/glm-api/ |
| 绘画 / 视频（网页） | https://geo.liuguang.ai/midjourney/ 、 https://geo.liuguang.ai/kling-api/ |

枢纽页：https://geo.liuguang.ai/

## 4. 和「纯中转」差在哪（个人看法）

纯中转往往只有密钥和价目；流光AI 多了工作台和智能体，适合「先在网页对齐效果 → 再把同一模型 ID 写进 API」。如果你已经深度绑定某一家官方企业合同，直连官方仍然更合适。

有踩坑欢迎回帖补充（限速、某模型是否上架等以你账号实时页面为准）。
