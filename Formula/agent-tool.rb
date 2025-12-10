class AgentTool < Formula
  desc "CLI to create, list and manage per-task agent workspaces for Git repositories"
  homepage "https://github.com/est7/agent-tool"
  url "https://github.com/est7/agent-tool/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "4c23cb48d2971865126af3e9065bc4649dfae502c5a34ad8ca547abe6c8fd8cc"
  license "MIT"

  def install
    # 安装主脚本
    libexec.install "agent-tool.sh"

    # 自动安装所有子目录（排除不需要的）
    Dir.glob("*/").each do |dir|
      dir_name = dir.chomp("/")
      next if %w[draft temp .git].include?(dir_name)

      libexec.install dir_name
    end

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

