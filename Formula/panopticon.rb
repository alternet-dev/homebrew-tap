# typed: false
# frozen_string_literal: true

require_relative "../lib/private_strategy"

class Panopticon < Formula
  desc "Codebase analysis engine and MCP server for AI agents"
  homepage "https://github.com/alternet-dev/panopticon"
  license :cannot_represent

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/alternet-dev/panopticon/releases/download/v1.0.0/pan-v1.0.0-aarch64-apple-darwin.tar.gz", using: GitHubPrivateReleaseDownload
      sha256 "ad50730da0929c77f6ab9f922e007ed6c5b78791dfb2f44b6c6ae4c3ff396f15"
    else
      url "https://github.com/alternet-dev/panopticon/releases/download/v1.0.0/pan-v1.0.0-x86_64-apple-darwin.tar.gz", using: GitHubPrivateReleaseDownload
      sha256 "ce63d28b4bf1c8db0e6a20276bdac2c352ec3a3ab1199e284aeb7c1691b12f31"
    end
  elsif OS.linux?
    url "https://github.com/alternet-dev/panopticon/releases/download/v1.0.0/pan-v1.0.0-x86_64-unknown-linux-gnu.tar.gz", using: GitHubPrivateReleaseDownload
    sha256 "240beab8f6a626b567f1b3a4421774152890f669ada766ad6330e17e57b7b538"
  end

  def install
    bin.install "pan"
  end

  def caveats
    <<~EOS
      Panopticon is installed. The binary is called `pan`.

      MCP setup for Claude Code:

        claude mcp add panopticon -- #{opt_bin}/pan mcp --path /path/to/repo

      Or add to your project's .claude.json:

        {
          "mcpServers": {
            "panopticon": {
              "command": "#{opt_bin}/pan",
              "args": ["mcp", "--path", "/path/to/your/repo"]
            }
          }
        }
    EOS
  end

  test do
    assert_match "pan", shell_output("#{bin}/pan version")
  end
end
