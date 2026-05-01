#!/bin/bash
# =====================================================
# WSL Chrome CDP - 关闭标签页
# 用途：关闭指定的标签页
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
    echo "用法: $0 <标签页ID>"
    echo "示例: $0 32488BC5B8F657BCE6CE27975694E8EE"
    echo ""
    echo "查看所有标签页: ./list-tabs.sh"
    exit 1
fi

TAB_ID="$1"

# 检查 CDP 是否就绪
log "检查 CDP 连接..."
if ! curl -s --connect-timeout 3 "$CDP_URL/json/version" > /dev/null 2>&1; then
    echo "❌ Chrome CDP 未就绪，请先运行 enable-browser.sh"
    exit 1
fi

# 关闭标签页
log "关闭标签页: $TAB_ID"
curl -X PUT "$CDP_URL/json/close/$TAB_ID" 2>&1

ok "标签页已关闭"
