  class AgentTool < Formula
    desc "CLI to create, list and manage per-task agent workspaces for Git repositories"
    homepage "https://github.com/est7/agent-tool"
    url "https://github.com/est7/agent-tool/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "50ce5ae1c1d59129f354c20ad847d8141cf16e06f2798e8a86091d6db11b9b30"
    license "MIT"

    depends_on "git"

    def install
      bin.install "agent-tool.sh" => "agent-tool"
    end

    test do
      system "#{bin}/agent-tool", "list"
    end
  end
