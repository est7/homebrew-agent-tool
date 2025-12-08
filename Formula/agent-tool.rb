class AgentTool < Formula
    desc "CLI to create, list and manage per-task agent workspaces for Git repositories"
    homepage "https://github.com/est7/agent-tool"
    url "https://github.com/est7/agent-tool/archive/refs/tags/v0.5.0.tar.gz"
    sha256 "61f3d11231a4815e3d6d17cb69b10a79be043f9ba0995b93436c5d7c94e27f7e"
    license "MIT"

    def install
      # 把主脚本和所有模块目录一起装到 libexec 下
      libexec.install "agent-tool.sh",
                      "cfg",
                      "ws",
                      "build",
                      "doctor",
                      "dev",
                      "test"

      # 确保主脚本可执行
      chmod 0o755, libexec/"agent-tool.sh"

      # bin 下放 wrapper，真正执行 libexec 里的脚本
      (bin/"agent-tool").write_env_script libexec/"agent-tool.sh", {}
    end

    test do
      # 为了通过 REPO_ROOT 校验，这里建一个最小 git 仓库
      system "git", "init", "."

      # 使用新的 ws 分组命令；只要不报错即可
      system "#{bin}/agent-tool", "ws", "list"
    end
  end
