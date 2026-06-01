# homebrew-tap

The [Homebrew](https://brew.sh) tap for [alternet-dev](https://github.com/alternet-dev)'s
open-source tools.

Tap it once; from then on `brew install <tool>` and `brew upgrade` work for any
formula listed below.

## Setup

```bash
brew tap alternet-dev/tap
```

(The repository is `alternet-dev/homebrew-tap`; Homebrew drops the `homebrew-`
prefix, so the tap name is `alternet-dev/tap`.)

## Formulae

| Formula | Upstream | Description |
|---------|----------|-------------|
| `wavefront-bundle` | [alternet-dev/wavefront](https://github.com/alternet-dev/wavefront) | Build and maintain versioned layers in a wavefront edge-proxy bundle |
| `wss-mux` | [alternet-dev/wss-mux](https://github.com/alternet-dev/wss-mux) | WebSocket multiplexer for server-driven event fanout |

```bash
brew install alternet-dev/tap/wavefront-bundle
brew install alternet-dev/tap/wss-mux
```

Once the tap is added the short form works too — `brew install wavefront-bundle`.

Both formulae ship prebuilt release binaries for arm64-macOS, x86_64-Linux, and arm64-Linux.

## Upgrading

```bash
brew update
brew upgrade                   # every formula
brew upgrade wavefront-bundle  # one formula
```

## Publishing from an upstream (recommended)

Both formulae here follow this pattern: the upstream's release workflow renders
its formula and pushes it to this tap automatically on each tag. See the
`update-tap` job in `alternet-dev/wavefront`'s and `alternet-dev/wss-mux`'s
`.github/workflows/release.yml` for working examples.

The pattern:

1. Render a Homebrew formula in the upstream's release workflow — either from a
   template at `packaging/homebrew-<name>.rb` (placeholders like
   `TAG_PLACEHOLDER`, `SHA256_*` per platform) or via a shell-script generator.
   Both formulae ship prebuilt per-platform tarballs, so the rendered formula
   carries a `url`/`sha256` pair per OS/arch rather than a source `tag`/`revision`.
2. The same workflow mints an installation token via
   [`actions/create-github-app-token@v2`](https://github.com/actions/create-github-app-token)
   using the **Alternet Tap Publisher** App's credentials, clones this tap, writes
   the rendered formula to `Formula/<name>.rb`, commits, and pushes.
3. The App is installed on this tap with `contents: write`. To onboard a new
   upstream, extend the App's credential secrets at the org level
   (`vars.HOMEBREW_TAP_APP_ID`, `secrets.HOMEBREW_TAP_APP_PRIVATE_KEY`) to include
   that repo — no per-upstream PAT.

The manual flow below remains available for tools that don't use this pattern.

## Adding a formula

Drop a new file in `Formula/<name>.rb`. Both formulae here ship prebuilt
per-platform tarballs, so the typical shape is bottle-style:

```text
class MyTool < Formula
  desc "..."
  homepage "https://github.com/alternet-dev/my-tool"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/alternet-dev/my-tool/releases/download/v1.0.0/my-tool-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "..."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/alternet-dev/my-tool/releases/download/v1.0.0/my-tool-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "..."
    end
    on_arm do
      url "https://github.com/alternet-dev/my-tool/releases/download/v1.0.0/my-tool-v1.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "..."
    end
  end

  def install
    bin.install "my-tool"
  end

  test do
    # exercise the built binary
  end
end
```

For source-built formulae instead, pin to the tag's immutable commit and build
with the language toolchain:

```text
url "https://github.com/alternet-dev/my-tool.git",
    tag:      "v1.0.0",
    revision: "<commit SHA of the tag>"
depends_on "go" => :build # or "rust" => :build

def install
  system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/my-tool"
end
```

GitHub's generated `/archive/` tarballs are not checksum-stable, so source
formulae pin to the tag's immutable commit. Resolve it with
`git ls-remote https://github.com/alternet-dev/<repo>.git refs/tags/<tag>^{}`.

Validate before opening a PR:

```bash
brew style alternet-dev/tap
brew audit --tap alternet-dev/tap
brew install <name>
```

CI (`.github/workflows/tests.yml`) runs the same style + audit checks on every
pull request.

## Releasing a new version

For tools using the upstream-driven pattern (both formulae here today), cutting
a new tag on the upstream automatically pushes the rendered formula to this
tap — no manual step.

`brew livecheck <formula>` reports when an upstream tag is newer than the
formula on the tap.

The `bump formula` workflow in `.github/workflows/bump.yml` is a legacy fallback
for source-built formulae and is not used by any current formula.

## Repository layout

```
Formula/            one .rb per tool
.github/workflows/  tap audit (tests.yml) and legacy bump (bump.yml)
```

## License

See [LICENSE](LICENSE).
