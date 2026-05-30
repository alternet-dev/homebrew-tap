class WavefrontBundle < Formula
  desc "Build and maintain versioned layers in a wavefront edge-proxy bundle"
  homepage "https://github.com/alternet-dev/wavefront"
  version "0.6.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.6.0/wavefront-bundle-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "b80096fd38f9269ca9ae40c8b5ede6f9afe40835232a820b076293c52ebc6516"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.6.0/wavefront-bundle-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dc5673e4d126e3c413a2e242df70ef23e8ef502ba5c1f31dcd3076673628d674"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.6.0/wavefront-bundle-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "544ee91b36a09b9e1691821c22cc1406e8d29e5fae1623fa8784b06118e6e621"
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
