class WavefrontBundle < Formula
  desc "Build and maintain versioned layers in a wavefront edge-proxy bundle"
  homepage "https://github.com/alternet-dev/wavefront"
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
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.3/wavefront-bundle-v0.7.3-aarch64-apple-darwin.tar.gz"
      sha256 "ba18d889d4a952da98a0efff88700177d3f5b90f6d7037a1ce93aaec18f3ba99"
    end
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.3/wavefront-bundle-v0.7.3-aarch64-apple-darwin.tar.gz"
      sha256 "ba18d889d4a952da98a0efff88700177d3f5b90f6d7037a1ce93aaec18f3ba99"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.3/wavefront-bundle-v0.7.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3da761d213bb8c132c5744ef9200f3c09f70a47524785f3f7bb402fc1b76cc4e"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.3/wavefront-bundle-v0.7.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ad869815f84284c9fb68cb962a5dcd3ce5030400604e096ddb09a98b746a6b2"
    end
  end

  def install
    bin.install "wavefront-bundle"
    doc.install "README.md", "LICENSE-MIT", "LICENSE-APACHE"
  end

  test do
    # wavefront-bundle is a subcommand CLI; a bare invocation prints usage
    # and exits 2.
    output = shell_output("#{bin}/wavefront-bundle 2>&1", 2)
    assert_match(/usage: wavefront-bundle/, output)
  end
end
