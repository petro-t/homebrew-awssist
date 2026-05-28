cask "awssist" do
  version "0.2.0"
  sha256 "4d1afe40980aa28265932496d1f574b53905088a385e451cb1f114243f14aa40"

  url "https://github.com/petro-t/awssist/releases/download/v#{version}/AWSsist-#{version}-arm64.dmg",
      verified: "github.com/petro-t/awssist/"
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
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/AWSsist.app"],
                   sudo: false
  end

  uninstall quit: "com.awssist.app"

  zap trash: [
    "~/Library/Application Support/awssist",
    "~/Library/Logs/AWSsist",
    "~/Library/Preferences/com.awssist.app.plist",
    "~/Library/Saved Application State/com.awssist.app.savedState",
  ]
end
