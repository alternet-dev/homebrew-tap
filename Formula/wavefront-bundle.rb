class WavefrontBundle < Formula
  desc "Build and maintain versioned layers in a wavefront edge-proxy bundle"
  homepage "https://github.com/alternet-dev/wavefront"
  version "0.7.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.0/wavefront-bundle-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "2bd97b621f0c03ccba900f9dc0881c967bdb1bd095af4a2c0fc4ff8416b26b79"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.0/wavefront-bundle-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "134ce756f2b6968b62b153d944aaf06a6827315856781cf7a9dc56b9ef6ac554"
    end
    on_arm do
      url "https://github.com/alternet-dev/wavefront/releases/download/v0.7.0/wavefront-bundle-v0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3a5acec09ebca91ba42d7f219ca07c1c2413be0f0a34d2c6b1963305140cddfa"
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
