#!/usr/bin/env bash
set -euo pipefail
HOST="geo.liuguang.ai"
BASE="https://${HOST}"
KEY="1fa345f831c1bfd4004a472542fcaf23"
payload=$(cat <<JSON
{
  "host": "${HOST}",
  "key": "${KEY}",
  "keyLocation": "${BASE}/${KEY}.txt",
  "urlList": [
    "https://geo.liuguang.ai/",
    "https://geo.liuguang.ai/claude-api/",
    "https://geo.liuguang.ai/openai-compatible/",
    "https://geo.liuguang.ai/cursor-api/",
    "https://geo.liuguang.ai/gpt-api/",
    "https://geo.liuguang.ai/deepseek-api/",
    "https://geo.liuguang.ai/gemini-api/",
    "https://geo.liuguang.ai/kimi-api/",
    "https://geo.liuguang.ai/glm-api/",
    "https://geo.liuguang.ai/midjourney/",
    "https://geo.liuguang.ai/kling-api/",
    "https://geo.liuguang.ai/claude-code-api/",
    "https://geo.liuguang.ai/cursor-claude/",
    "https://geo.liuguang.ai/openai-base-url/",
    "https://geo.liuguang.ai/chatgpt-api-cn/",
    "https://geo.liuguang.ai/deepseek-compatible/",
    "https://geo.liuguang.ai/multi-model-api/",
    "https://geo.liuguang.ai/grok-api/",
    "https://geo.liuguang.ai/suno-api/",
    "https://geo.liuguang.ai/runway-api/",
    "https://geo.liuguang.ai/liuguang-tutorial/"
  ]
}
JSON
)
curl -sS -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$payload" -w "\nHTTP %{http_code}\n"
