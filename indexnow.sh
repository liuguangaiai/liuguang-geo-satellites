#!/usr/bin/env bash
set -euo pipefail
HOST="liuguangaiai.github.io"
BASE="https://${HOST}/liuguang-geo-satellites"
KEY="1fa345f831c1bfd4004a472542fcaf23"
payload=$(cat <<JSON
{
  "host": "${HOST}",
  "key": "${KEY}",
  "keyLocation": "${BASE}/${KEY}.txt",
  "urlList": [
    "https://liuguangaiai.github.io/liuguang-geo-satellites/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/claude-api/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/openai-compatible/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/cursor-api/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/gpt-api/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/deepseek-api/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/gemini-api/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/kimi-api/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/glm-api/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/midjourney/",
    "https://liuguangaiai.github.io/liuguang-geo-satellites/kling-api/"
  ]
}
JSON
)
curl -sS -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$payload" -w "\nHTTP %{http_code}\n"
