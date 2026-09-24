cask "awssist" do
  version "0.2.4"
  sha256 "80beb7e7f20f8d7a99d6efd320d5f445bc2fc75e8db5ea2f8df446a608c65256"

  url "https://github.com/petro-t/awssist/releases/download/v#{version}/AWSsist-#{version}-arm64.dmg"
  name "AWSsist"
  desc "Desktop AWS profile and session manager"
  homepage "https://github.com/petro-t/awssist"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "AWSsist.app"

  # AWSsist is not yet code-signed/notarized. Without this, macOS Gatekeeper
  # would refuse to launch the freshly-copied app with a "damaged" message.
  # Stripping the quarantine xattr that Homebrew applies to the downloaded DMG
  # lets the user open the app normally on first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/AWSsist.app"]
  end

  uninstall quit: "com.awssist.app"

  zap trash: [
    "~/Library/Application Support/awssist",
    "~/Library/Logs/AWSsist",
    "~/Library/Preferences/com.awssist.app.plist",
    "~/Library/Saved Application State/com.awssist.app.savedState",
  ]
end
