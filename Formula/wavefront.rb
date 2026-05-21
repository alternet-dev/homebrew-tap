# typed: false
# frozen_string_literal: true

class Wavefront < Formula
  desc "Edge proxy mapping a versioned external contract onto one internal backend"
  homepage "https://github.com/alternet-dev/wavefront"
  # GitHub's generated /archive/ tarballs are not checksum-stable; pin to the
  # tag's immutable commit instead.
  url "https://github.com/alternet-dev/wavefront.git",
      tag:      "v0.2.0",
      revision: "833fcf5d83f764be0fab61dbf454231b19e36f41"
  license any_of: ["Apache-2.0", "MIT"]

  livecheck do
    url :stable
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
