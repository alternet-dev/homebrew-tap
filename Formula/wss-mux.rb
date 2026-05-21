# typed: false
# frozen_string_literal: true

class WssMux < Formula
  desc "WebSocket multiplexer for server-driven event fanout"
  homepage "https://github.com/alternet-dev/wss-mux"
  url "https://github.com/alternet-dev/wss-mux/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "408c217dc49666ef4ea6be649b2a289c8ee6fd08add06741428d1784cef98b70"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url "https://github.com/alternet-dev/wss-mux.git"
    strategy :git
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # wss-mux is configured entirely through WSS_MUX_* environment variables and
    # has no stream manifest by default, so a bare invocation must fail fast
    # rather than start a server.
    output = shell_output("#{bin}/wss-mux 2>&1", 1)
    assert_match(/wss[\s_-]?mux|manifest|WSS_MUX/i, output)
  end
end
