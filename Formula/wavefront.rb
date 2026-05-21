# typed: false
# frozen_string_literal: true

class Wavefront < Formula
  desc "Edge proxy mapping a versioned external contract onto one internal backend"
  homepage "https://github.com/alternet-dev/wavefront"
  url "https://github.com/alternet-dev/wavefront/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "508f2b06f2f3ded25a22d6a67fce2acd23c98d27e84d2d0f43469cef94c40588"
  license any_of: ["Apache-2.0", "MIT"]

  livecheck do
    url "https://github.com/alternet-dev/wavefront.git"
    strategy :git
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w"
    %w[wavefront wavefront-bundlegen].each do |cmd|
      system "go", "build", *std_go_args(ldflags: ldflags, output: bin/cmd), "./cmd/#{cmd}"
    end
  end

  test do
    # wavefront validates its bundle on startup and refuses to start without a
    # valid one, so a bare invocation must fail fast.
    output = shell_output("#{bin}/wavefront 2>&1", 1)
    assert_match(/invalid configuration|bundle|wavefront/i, output)
  end
end
