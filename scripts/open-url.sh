#!/bin/bash
# =====================================================
# WSL Chrome CDP - 打开网页
# 用途：通过 CDP API 打开网页（绕过 SSRF 限制）
# 作者：杏子
# 创建日期：2026-05-01
# =====================================================

set -e

CDP_PORT="${CDP_PORT:-9222}"
CDP_URL="http://127.0.0.1:$CDP_PORT"

# 颜色
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${CYAN}[INFO]${NC} $1"; }
ok() { echo -e "${GREEN}[✓]${NC} $1"; }

# 检查参数
if [ -z "$1" ]; then
    echo "用法: $0 <URL>"
    echo "示例: $0 https://www.bilibili.com"
    exit 1
fi

URL="$1"

# 检查 CDP 是否就绪
log "检查 CDP 连接..."
if ! curl -s --connect-timeout 3 "$CDP_URL/json/version" > /dev/null 2>&1; then
    echo "❌ Chrome CDP 未就绪，请先运行 enable-browser.sh"
    exit 1
fi

# 打开网页
log "打开网页: $URL"
response=$(curl -s -X PUT "$CDP_URL/json/new?$URL")

# 解析结果
tab_id=$(echo "$response" | grep -o '"id": "[^"]*"' | cut -d'"' -f4)
tab_title=$(echo "$response" | grep -o '"title": "[^"]*"' | cut -d'"' -f4)
tab_url=$(echo "$response" | grep -o '"url": "[^"]*"' | cut -d'"' -f4)

if [ -n "$tab_id" ]; then
    ok "网页已打开"
    echo "  标签页 ID: $tab_id"
    echo "  URL: $tab_url"
    [ -n "$tab_title" ] && echo "  标题: $tab_title"
else
    echo "❌ 打开网页失败"
    echo "响应: $response"
    exit 1
fi
