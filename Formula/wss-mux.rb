# typed: false
# frozen_string_literal: true

class WssMux < Formula
  desc "WebSocket multiplexer for server-driven event fanout"
  homepage "https://github.com/alternet-dev/wss-mux"
  # GitHub's generated /archive/ tarballs are not checksum-stable; pin to the
  # tag's immutable commit instead.
  url "https://github.com/alternet-dev/wss-mux.git",
      tag:      "v0.5.0",
      revision: "3d4fb32d7f1ef4bd4e3072abac4877e866e6448d"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
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
