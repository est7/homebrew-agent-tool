  class AgentTool < Formula
    desc "CLI to create, list and manage per-task agent workspaces for Git repositories"
    homepage "https://github.com/est7/agent-tool"
    url "https://github.com/est7/agent-tool/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "d70416aff8b7e0950011ec34808b808ae86d70dafff96406db2e72e594f6afee"
    license "MIT"

    depends_on "git"

    def install
      bin.install "agent-tool.sh" => "agent-tool"
    end

    test do
      system "#{bin}/agent-tool", "list"
    end
  end
