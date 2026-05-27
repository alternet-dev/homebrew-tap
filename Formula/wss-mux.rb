class WssMux < Formula
  desc "WebSocket multiplexer for server-driven event fanout"
  homepage "https://github.com/alternet-dev/wss-mux"
  version "0.5.3"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.5.3/wss-mux-v0.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "1a1b1f97af05accfcc04546af258f8f91f592fcbcf7a5f02e61c5fdd0486e11b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.5.3/wss-mux-v0.5.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0cb460da16a5b86db49f276d343e0cfd14ce30702ecfb157a8824962d95a2c21"
    end
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.5.3/wss-mux-v0.5.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6c6d769ad5ea3634cb9aa62169ec086ba737400184ce9956dd16603bc9176943"
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
