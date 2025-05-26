cask "firefox-esr" do
  version "128.10.1"

  language "en", default: true do
    sha256 "d422ae4b858cf531e476193dbe6cd689562d8e266200fb37c250db8c7474bf0b"
    "en-US"
  end

  url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{version}esr/mac/en-US/Firefox%20#{version}esr.dmg"
  name "Mozilla Firefox ESR (Extended Support Release)"
  desc "Extended Support Release of Firefox"
  homepage "https://www.mozilla.org/en-US/firefox/enterprise/"

  auto_updates true
  conflicts_with cask: "firefox"
  depends_on macos: ">= :sierra"

  livecheck do
    url "https://download.mozilla.org/?product=firefox-esr-latest&os=osx&lang=en-US"
    strategy :header_match
  end

  app "Firefox.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.mozilla.firefox.sfl*",
    "~/Library/Application Support/CrashReporter/firefox_*",
    "~/Library/Application Support/Firefox",
    "~/Library/Caches/Firefox",
    "~/Library/Caches/Mozilla/updates/Applications/Firefox",
    "~/Library/Caches/org.mozilla.crashreporter",
    "~/Library/Caches/org.mozilla.firefox",
    "~/Library/Preferences/org.mozilla.crashreporter.plist",
    "~/Library/Preferences/org.mozilla.firefox.plist",
    "~/Library/Saved Application State/org.mozilla.firefox.savedState",
    "~/Library/WebKit/org.mozilla.firefox",
    "/Library/Logs/DiagnosticReports/firefox_*",
  ],
  rmdir: [
    # "~/Library/Application Support/Mozilla", #  May also contain non-Firefox data
    "~/Library/Caches/Mozilla/updates/Applications",
    "~/Library/Caches/Mozilla/updates",
    "~/Library/Caches/Mozilla",
  ]
end
