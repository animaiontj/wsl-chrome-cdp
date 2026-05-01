#!/bin/bash
# =====================================================
# WSL Chrome CDP - 截图
# 用途：截取当前页面或指定标签页的截图
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

# 检查 CDP 是否就绪
log "检查 CDP 连接..."
if ! curl -s --connect-timeout 3 "$CDP_URL/json/version" > /dev/null 2>&1; then
    echo "❌ Chrome CDP 未就绪，请先运行 enable-browser.sh"
    exit 1
fi

# 获取标签页列表
log "获取标签页列表..."
tabs=$(curl -s "$CDP_URL/json/list")

# 查找第一个页面类型的标签页
first_page=$(echo "$tabs" | grep -o '"type": "page"' -B 5 | grep '"id"' | head -1 | cut -d'"' -f4)

if [ -z "$first_page" ]; then
    echo "❌ 没有找到可截图的标签页"
    exit 1
fi

# 使用 OpenClaw browser 工具截图
log "截取标签页: $first_page"
openclaw browser screenshot --target-id "$first_page" 2>&1

ok "截图完成"
