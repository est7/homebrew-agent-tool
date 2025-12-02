# Homebrew 发布流程（agent-tool）

本文档说明：当 `agent-tool` 源代码有更新时，如何发布新版本、更新 Homebrew 三方库（tap），以及用户如何安装/升级使用。

假设：
- 源码仓库：`https://github.com/est7/agent-tool`
- Homebrew tap 仓库（当前仓库）：`https://github.com/est7/homebrew-agent-tool`
- tap 名称：`est7/agent-tool`

---

## 一、在源码仓库发布新版本

1. 在源码仓库中完成代码修改并提交：
   - `git add ...`
   - `git commit -m "feat: ..."`
   - `git push`
2. 确定新的版本号，例如：`v0.1.1`（建议遵循 SemVer）。
3. 在源码仓库打 tag 并推送：
   - `git tag v0.1.1`
   - `git push origin v0.1.1`
4. 确认 GitHub 上已经存在 `v0.1.1` 对应的 tag（以及自动生成的源码压缩包 URL）：
   - `https://github.com/est7/agent-tool/archive/refs/tags/v0.1.1.tar.gz`

---

## 二、更新 Homebrew 配方（本仓库）

1. 拉取本仓库最新代码：
   - `git pull`
2. 下载新版本源码压缩包并计算 SHA256：
   - `curl -L -o agent-tool-v0.1.1.tar.gz https://github.com/est7/agent-tool/archive/refs/tags/v0.1.1.tar.gz`
   - `shasum -a 256 agent-tool-v0.1.1.tar.gz`
   - 记录输出的哈希值（64 位十六进制字符串）。
3. 编辑 `Formula/agent-tool.rb`：
   - 更新 `url` 指向新的 tag：
     - `url "https://github.com/est7/agent-tool/archive/refs/tags/v0.1.1.tar.gz"`
   - 更新 `sha256` 为上一步获得的新哈希值。
   - 如有需要，可同步更新描述、依赖等字段。
4. 本地验证配方是否可正常安装：
   - 在本仓库根目录执行：`brew install --build-from-source ./Formula/agent-tool.rb`
   - 验证命令是否可用：`agent-tool --help` 或 `agent-tool list`
5. 提交并推送到 tap 仓库：
   - `git add Formula/agent-tool.rb`
   - `git commit -m "chore: bump agent-tool to v0.1.1"`
   - `git push`

当上述更改推送到 GitHub 后，其他机器上的 Homebrew 即可通过该 tap 安装/升级新版本。

---

## 三、用户侧安装与升级

### 1. 首次使用：添加 tap 并安装

1. 添加 tap（只需一次）：
   - `brew tap est7/agent-tool`
2. 安装 `agent-tool`：
   - `brew install agent-tool`
3. 验证安装：
   - `agent-tool --help`
   - 或 `agent-tool list`

### 2. 已安装用户的升级

- 更新 Homebrew 仓库信息：
  - `brew update`
- 升级 `agent-tool`：
  - `brew upgrade agent-tool`
- 查看当前已安装版本：
  - `brew info agent-tool`

### 3. 卸载（可选）

- 卸载 `agent-tool`：
  - `brew uninstall agent-tool`
- 若不再需要该 tap：
  - `brew untap est7/agent-tool`

---

## 四、快速检查清单

每次发布新版本时，可按以下顺序自检：

1. 源码仓库：
   - [ ] 代码已合并到主分支
   - [ ] 已打 tag（如 `v0.1.1`），并推送到远端
2. Homebrew tap 仓库：
   - [ ] `Formula/agent-tool.rb` 中的 `url` 指向新的 tag
   - [ ] `sha256` 已按新压缩包重新计算并更新
   - [ ] 本地能通过 `brew install --build-from-source ./Formula/agent-tool.rb` 安装
   - [ ] 变更已提交并推送到 GitHub

