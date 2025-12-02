   class AgentTool < Formula
    desc "CLI to create, list and manage per-task agent workspaces for Git repositories"
    homepage "https://github.com/est7/agent-tool"
    url "https://github.com/est7/agent-tool/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "d70416aff8b7e0950011ec34808b808ae86d70dafff96406db2e72e594f6afee"
    license "MIT"

    depends_on "git"

    def install
      # 所有脚本装到同一个 libexec 目录
      libexec.install "agent-tool.sh",
                      "agent-workspace.sh",
                      "agent-android.sh",
                      "agent-ios.sh",
                      "agent-web.sh"

      # 在 bin 下生成一个 wrapper，实际执行 libexec 里的主脚本
      (bin/"agent-tool").write_env_script libexec/"agent-tool.sh", {}
    end

    test do
      # 在测试目录初始化一个最小 git 仓库，让脚本能找到 REPO_ROOT
      system "git", "init", "."
      system "#{bin}/agent-tool", "list"
    end
  end
