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
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.4/wavefront-bundle-v0.7.4-aarch64-apple-darwin.tar.gz"
      sha256 "575f2f12cb4d0b2f02c737737828cce2cccea1a04af399cea87ccfc94b4b5dd6"
    end
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.4/wavefront-bundle-v0.7.4-aarch64-apple-darwin.tar.gz"
      sha256 "575f2f12cb4d0b2f02c737737828cce2cccea1a04af399cea87ccfc94b4b5dd6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.4/wavefront-bundle-v0.7.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d0afdb45cff8d7152dad0d56f0de5331f6bd0335ed88b575af86647098ce5927"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.4/wavefront-bundle-v0.7.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ee5aa9307a21cec846a8be65fd998e6a79c708576b38eea57a9806cd2f83c0e"
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
