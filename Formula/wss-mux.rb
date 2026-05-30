class WssMux < Formula
  desc "WebSocket multiplexer for server-driven event fanout"
  homepage "https://github.com/alternet-dev/wss-mux"
  version "0.6.1"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.1/wss-mux-v0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "fd400cc027fa2df5d7d74b2e8683a5212166ed1cae578793ec8640a9bf18523a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.1/wss-mux-v0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d031af9cf7ba9b9d52350fd3add6a6845d8e765caadaa2428ea1e741745e0312"
    end
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.1/wss-mux-v0.6.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d3e1e30879e4167e5145eb42ebfcdf8aa73d759db592362a7e46dac1a1788b2f"
    end
  end

  def install
    bin.install "wss-mux"
    doc.install "README.md", "LICENSE-MIT", "LICENSE-APACHE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wss-mux --version")
  end
end
