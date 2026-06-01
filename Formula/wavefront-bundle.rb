class WavefrontBundle < Formula
  desc "Build and maintain versioned layers in a wavefront edge-proxy bundle"
  homepage "https://github.com/alternet-dev/wavefront"
  version "0.7.1"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.1/wavefront-bundle-v0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "98bd3af094f682f2f3ea45f299c95bb19d06737ec6e24bed6108ffdacd746df4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.1/wavefront-bundle-v0.7.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10534a537feedda11a5276e1fe9fd45edef80633612e55e30abaa68d4a5c85f3"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.1/wavefront-bundle-v0.7.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cd2a837ff649f495d5ca87e9c03ccd9087d2957d418a89b9f4292425a0efb6e9"
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
