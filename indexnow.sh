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
    "${BASE}/",
    "${BASE}/claude-api/",
    "${BASE}/openai-compatible/",
    "${BASE}/cursor-api/"
  ]
}
JSON
)
curl -sS -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$payload" -w "\nHTTP %{http_code}\n"
