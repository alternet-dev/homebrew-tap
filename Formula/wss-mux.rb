class WssMux < Formula
  desc "WebSocket multiplexer for server-driven event fanout"
  homepage "https://github.com/alternet-dev/wss-mux"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    # We only ship an arm64-mac binary. `depends_on arch: :arm64` aborts
    # `brew install` on Intel macOS before any URL is fetched. The
    # `on_intel` block below reuses the arm64 URL as a stub so that
    # `brew readall --os=all --arch=all` (which requires a URL for every
    # OS/arch combination it evaluates) is satisfied; that URL is never
    # actually downloaded in a real install on Intel macOS.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.2/wss-mux-v0.6.2-aarch64-apple-darwin.tar.gz"
      sha256 "e63d5c03ae3a610f1f71d7f4fa259142a1651182a32fa1d4e2a21fd169f0631b"
    end
    on_intel do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.2/wss-mux-v0.6.2-aarch64-apple-darwin.tar.gz"
      sha256 "e63d5c03ae3a610f1f71d7f4fa259142a1651182a32fa1d4e2a21fd169f0631b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.2/wss-mux-v0.6.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25a7da974a369508bf9184a5e4a829f49b76f3320e7c1a187380aed324a0d425"
    end
    on_arm do
      url "https://github.com/alternet-dev/wss-mux/releases/download/v0.6.2/wss-mux-v0.6.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "42f21452d5b0e1aa3b66f63c9a9850ff8dcc4d069da9c1601853625b7f2a1d85"
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
