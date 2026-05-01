#!/bin/bash
# =====================================================
# WSL Chrome CDP - 列出所有标签页
# 用途：列出当前所有打开的标签页
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

# 格式化输出
echo "$tabs" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print()
print('标签页列表:')
print('-' * 80)
for i, tab in enumerate(data, 1):
    tab_type = tab.get('type', 'unknown')
    if tab_type == 'page':
        title = tab.get('title', 'N/A')
        url = tab.get('url', 'N/A')
        tab_id = tab.get('id', 'N/A')
        print(f'{i}. [{tab_type}] {title}')
        print(f'   ID: {tab_id}')
        print(f'   URL: {url}')
        print()
" 2>&1

ok "共 $(echo "$tabs" | grep -c '"type": "page"') 个页面标签页"
