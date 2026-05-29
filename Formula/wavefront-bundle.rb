class WavefrontBundle < Formula
  desc "Build and maintain versioned layers in a wavefront edge-proxy bundle"
  homepage "https://github.com/alternet-dev/wavefront"
  version "0.5.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.5.0/wavefront-bundle-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "03da80d65a59cf62e3e9fccee4dccad08f08a76afc49c7b1e3fa4c535becfe3f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.5.0/wavefront-bundle-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8db174a789fb0449d20099080f8eed2716353c925311f7827bc446774618ca0d"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.5.0/wavefront-bundle-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "86ab6f761decfef8248daa48acc27796b5595cc80d0499cc123783316917fb63"
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
