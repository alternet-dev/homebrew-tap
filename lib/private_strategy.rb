# typed: false
# frozen_string_literal: true

require "download_strategy"
require "json"
require "uri"

# Downloads release assets from private alternet-dev GitHub repos via the API.
# A plain github.com/releases/download/ URL returns 404 for a private repo, so
# this strategy resolves the asset ID through the Releases API, then downloads
# the asset itself (the API redirects to a short-lived signed URL).
#
# Requires HOMEBREW_GITHUB_API_TOKEN with read access to the repo. `gh auth
# login` supplies one automatically; otherwise export a personal access token.
#
# Shared by every formula in this tap that packages a private repo. Use it from
# a formula like so:
#
#   require_relative "../lib/private_strategy"
#
#   url "https://github.com/alternet-dev/<repo>/releases/download/<tag>/<asset>",
#       using: GitHubPrivateReleaseDownload
class GitHubPrivateReleaseDownload < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN") do
      raise "HOMEBREW_GITHUB_API_TOKEN is required to install from a private GitHub repo"
    end

    # Parse owner/repo/tag/filename out of the github.com release URL.
    owner, repo, tag, filename = URI.parse(url).path.split("/").values_at(1, 2, 5, 6)

    # Look up the asset ID via the Releases API.
    api = "https://api.github.com/repos/#{owner}/#{repo}/releases/tags/#{tag}"
    release = JSON.parse(Utils::Curl.curl_output(
      "--header", "Authorization: token #{token}",
      api
    ).stdout)
    asset = release.fetch("assets").find { |a| a["name"] == filename }
    raise "Asset #{filename} not found in release #{tag}" unless asset

    # Download the asset via the API (returns 302 -> signed URL).
    curl_download(
      asset["url"],
      "--header", "Authorization: token #{token}",
      "--header", "Accept: application/octet-stream",
      "--location",
      to:      temporary_path,
      timeout: timeout
    )
  end
end
