class WssMux < Formula
  desc "WebSocket multiplexer for server-driven event fanout"
  homepage "https://github.com/alternet-dev/wss-mux"
  version "0.6.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.0/wss-mux-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "099db9ab3b72055a98836c58e435aa8c9e4a53939601bd2e0b30ed8faed2dfa6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.0/wss-mux-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d6477b6f8859dea16971f88bb57ef78258f9ada1a121e92e8b6f06a37f1678d7"
    end
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.0/wss-mux-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1fd63cc6bddc8ea9f34ceb616f1d108312fb381c65f32a8299e06d5aea6d238f"
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
