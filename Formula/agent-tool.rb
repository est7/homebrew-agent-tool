class AgentTool < Formula
    desc "CLI to create, list and manage per-task agent workspaces for Git repositories"
    homepage "https://github.com/est7/agent-tool"
    url "https://github.com/est7/agent-tool/archive/refs/tags/v0.4.0.tar.gz"
    sha256 "26fe80501457ab7ddd4044897b418ec68e05d6013b9248b682ecca70be729fbd"
    license "MIT"

    def install
      # 所有脚本装到同一个 libexec 目录
      libexec.install "agent-tool.sh",
                      "agent-workspace.sh",
                      "agent-android.sh",
                      "agent-ios.sh",
                      "agent-web.sh"

      # 确保主脚本有执行权限（避免升级后丢失 x 位）
      chmod 0o755, libexec/"agent-tool.sh"

      # 在 bin 下生成一个 wrapper，实际执行 libexec 里的主脚本
      (bin/"agent-tool").write_env_script libexec/"agent-tool.sh", {}
    end

    test do
      # 为了让脚本通过 REPO_ROOT 校验，这里建一个最小 git 仓库
      system "git", "init", "."
      system "#{bin}/agent-tool", "list"
    end
  end
