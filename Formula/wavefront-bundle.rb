class WavefrontBundle < Formula
  desc "Build and maintain versioned layers in a wavefront edge-proxy bundle"
  homepage "https://github.com/alternet-dev/wavefront"
  version "0.6.1"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.6.1/wavefront-bundle-v0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "003e317f065eba2f554d8fa5e7d7779c8425a6a7547388539f16620297f8c764"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.6.1/wavefront-bundle-v0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d8b936c04446ac3632dccf59fd44734400d93604f3933ea08e9020c90cd83a4"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.6.1/wavefront-bundle-v0.6.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6b16de780cc6d5482baa9ecb8b5dc868ab1d62ffcfe696ed5187081370ed6ac7"
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
