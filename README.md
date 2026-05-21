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

**Public repo, built from source** (see `wss-mux.rb`, `wavefront.rb`) — pin
`url` to the tag's commit and build with the language toolchain:

```text
class MyTool < Formula
  desc "..."
  homepage "https://github.com/alternet-dev/my-tool"
  url "https://github.com/alternet-dev/my-tool.git",
      tag:      "v1.0.0",
      revision: "<commit SHA of the tag>"
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

GitHub's generated `/archive/` tarballs are not checksum-stable, so formulae
pin to the tag's immutable commit. Resolve it with
`git ls-remote https://github.com/alternet-dev/<repo>.git refs/tags/<tag>^{}`.

**Private repo, prebuilt release binary** (see `panopticon.rb`) — reuse the
shared download strategy so the GitHub token is applied automatically:

```text
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
  (`workflow_dispatch`). Pick the formula and the new tag; it resolves the
  tag's commit and opens a PR. Covers the source-built formulae (`wss-mux`,
  `wavefront`).
- **Manual** — for `wss-mux`/`wavefront`, update `tag` and `revision` in
  `Formula/<name>.rb`. For `panopticon`, update the release `url` and `sha256`
  for each platform (every release publishes a matching `.sha256` file).

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
