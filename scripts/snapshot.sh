#!/bin/bash
# =====================================================
# WSL Chrome CDP - 获取页面快照
# 用途：获取页面的可访问性快照（用于分析页面结构）
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
    echo "示例: $0 t1"
    echo ""
    echo "查看所有标签页: curl -s http://127.0.0.1:9222/json/list"
    exit 1
fi

TARGET_ID="$1"

# 检查 CDP 是否就绪
log "检查 CDP 连接..."
if ! curl -s --connect-timeout 3 "$CDP_URL/json/version" > /dev/null 2>&1; then
    echo "❌ Chrome CDP 未就绪，请先运行 enable-browser.sh"
    exit 1
fi

# 使用 OpenClaw browser 工具获取快照
log "获取页面快照: $TARGET_ID"
openclaw browser snapshot --target-id "$TARGET_ID" 2>&1

ok "快照获取完成"
