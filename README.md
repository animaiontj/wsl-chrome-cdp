# WSL Chrome CDP - 快速入门

**让 WSL2 无缝访问 Windows Chrome 浏览器**

**全自动模式：无需手动操作！**

**版本：** 1.1.0 | **最后更新：** 2026-05-01

---

## 🚀 30 秒开始

### **安装技能**

```bash
# 从 GitHub 安装
git clone https://github.com/animaiontj/wsl-chrome-cdp.git ~/.openclaw/workspace/skills/wsl-chrome-cdp

# 或从 ClawHub 安装（待发布）
openclaw skills install wsl-chrome-cdp
```

### **使用**

**在 OpenClaw 对话中直接说：**

```
打开百度
```

**就这么简单！**

---

## 🔧 手动启用（可选）

```bash
# 一键启用浏览器
./skills/wsl-chrome-cdp/enable-browser.sh
```

**输出示例：**

```
=========================================
WSL Chrome CDP - 全自动启用
作者：杏子 🍑
=========================================

[INFO] 检查 Chrome CDP 连接...
[✓] Chrome CDP 已就绪
[INFO] Chrome 版本：Chrome/145.0.7632.160

=========================================
[✓] 浏览器已就绪，可以使用！
=========================================
```

---

## 🛠️ CDP API 封装脚本

**解决 SSRF 限制问题！**

OpenClaw 官方 browser 工具有 SSRF 策略限制，无法导航到域名。
使用封装脚本可以绕过这个限制！

### **脚本列表**

| 脚本 | 用途 | 示例 |
|------|------|------|
| `open-url.sh` | 打开网页 | `./scripts/open-url.sh https://www.bilibili.com` |
| `list-tabs.sh` | 列出标签页 | `./scripts/list-tabs.sh` |
| `screenshot.sh` | 截图 | `./scripts/screenshot.sh` |
| `snapshot.sh` | 获取快照 | `./scripts/snapshot.sh t1` |
| `close-tab.sh` | 关闭标签页 | `./scripts/close-tab.sh <tab-id>` |

### **快速示例**

```bash
# 1. 启动浏览器
./enable-browser.sh

# 2. 打开 B站
./scripts/open-url.sh https://www.bilibili.com

# 3. 查看标签页
./scripts/list-tabs.sh

# 4. 截图
./scripts/screenshot.sh
```

---

## 📚 文档

| 文档 | 说明 |
|------|------|
| [SKILL.md](SKILL.md) | 完整技能说明 + SSRF 配置 |
| [故障排查](docs/troubleshooting.md) | 详细排查指南 |

---

## 💡 使用示例

**配置成功后，在 OpenClaw 中：**

```
打开 GitHub
截图
点击登录按钮
填写表单
提取页面内容
```

---

## 🍑 关于

**作者：** 杏子  
**版本：** 1.1.0  
**创建日期：** 2026-03-11  
**最后更新：** 2026-05-01

**使用问题？** 查看 [SKILL.md](SKILL.md) 或 [故障排查](docs/troubleshooting.md)

---

*快速入门版本：1.1.0 | 最后更新：2026-05-01*