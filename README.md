# homebrew-tap

The default [Homebrew](https://brew.sh) tap for [alternet-dev](https://github.com/alternet-dev) —
one place for every alternet-managed command-line tool.

Tap it once; from then on `brew install <tool>` and `brew upgrade` work for any
formula listed below.

## Setup

```bash
brew tap alternet-dev/tap
```

(The repository is `alternet-dev/homebrew-tap`; Homebrew drops the `homebrew-`
prefix, so the tap name is `alternet-dev/tap`.)

Some formulae package **private** repositories and need GitHub authentication —
Homebrew reuses the GitHub CLI token:

```bash
gh auth login
```

Or export a personal access token with `repo` read scope:

```bash
export HOMEBREW_GITHUB_API_TOKEN=ghp_xxxxxxxxxxxx
```

## Formulae

| Formula | Upstream | Visibility | Description |
|---------|----------|------------|-------------|
| `panopticon` | [alternet-dev/panopticon](https://github.com/alternet-dev/panopticon) | private | Codebase analysis engine and MCP server for AI agents |
| `wss-mux` | [alternet-dev/wss-mux](https://github.com/alternet-dev/wss-mux) | public | WebSocket multiplexer for server-driven event fanout |
| `wavefront` | [alternet-dev/wavefront](https://github.com/alternet-dev/wavefront) | public | Edge proxy mapping a versioned external contract onto one internal backend |

```bash
brew install alternet-dev/tap/panopticon
brew install alternet-dev/tap/wss-mux
brew install alternet-dev/tap/wavefront
```

Once the tap is added the short form works too — `brew install wss-mux`.

## Upgrading

```bash
brew update
brew upgrade            # every formula
brew upgrade wss-mux    # one formula
```

## Adding a formula

Drop a new file in `Formula/<name>.rb`. This tap uses two patterns.

**Public repo, built from source** (see `wss-mux.rb`, `wavefront.rb`) — point
`url` at a tag archive and build with the language toolchain:

```ruby
class MyTool < Formula
  desc "..."
  homepage "https://github.com/alternet-dev/my-tool"
  url "https://github.com/alternet-dev/my-tool/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "..." # shasum -a 256 of the tarball above
  license "..."

  depends_on "rust" => :build # or "go" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # exercise the built binary
  end
end
```

**Private repo, prebuilt release binary** (see `panopticon.rb`) — reuse the
shared download strategy so the GitHub token is applied automatically:

```ruby
require_relative "../lib/private_strategy"

class MyTool < Formula
  # ...
  url "https://github.com/alternet-dev/my-tool/releases/download/v1.0.0/asset.tar.gz",
      using: GitHubPrivateReleaseDownload
  sha256 "..."
end
```

Validate before opening a PR:

```bash
brew style alternet-dev/tap
brew audit --tap alternet-dev/tap
brew install <name>
```

CI (`.github/workflows/tests.yml`) runs the same style + audit checks on every
pull request.

## Releasing a new version

When an upstream repo cuts a new tag, bump its formula:

- **Automated** — run the **bump formula** workflow from the Actions tab
  (`workflow_dispatch`). Pick the formula and the new tag; it recomputes the
  checksum and opens a PR. Covers the source-built formulae (`wss-mux`,
  `wavefront`).
- **Manual** — edit `url`/`sha256` in `Formula/<name>.rb`. `panopticon` ships a
  prebuilt binary per platform, so update all three `sha256` values (each
  release publishes a matching `.sha256` file alongside the asset).

`brew livecheck <formula>` reports when an upstream tag is newer than the
formula.

## Repository layout

```
Formula/            one .rb per tool
lib/                shared formula helpers (private-repo download strategy)
.github/workflows/  tap audit (tests.yml) and version bump (bump.yml)
```

## License

Proprietary and confidential. See [LICENSE](LICENSE).
