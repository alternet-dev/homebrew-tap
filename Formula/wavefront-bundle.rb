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
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.2/wavefront-bundle-v0.7.2-aarch64-apple-darwin.tar.gz"
      sha256 "683f81cb72bd322ef8a80ffac800877cc07ce2428a77d96201a0411688ef4171"
    end
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.2/wavefront-bundle-v0.7.2-aarch64-apple-darwin.tar.gz"
      sha256 "683f81cb72bd322ef8a80ffac800877cc07ce2428a77d96201a0411688ef4171"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.2/wavefront-bundle-v0.7.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae1e5e70c1467699599204a1f8dfa6e7d4a5a115e1aa37add86253da0f369dff"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.2/wavefront-bundle-v0.7.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "54bb9f5052bd34f246cf7b9cb3d08eb07280d71ee2113ece1badd702191222c8"
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
