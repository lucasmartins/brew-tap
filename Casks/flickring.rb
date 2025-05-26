# Homebrew Cask file for FlickRing

cask 'flickring' do
  version :latest # We'll use the latest version

  language "en", default: true do
    sha256 "a683b83736ce6800aaca53581519353acc315722eda9294d005404b805814c40"
    "en-US"
  end

  url 'https://flick-ring-updates.s3.amazonaws.com/FlickRing-latest.zip'
  name 'FlickRing'
  homepage 'https://github.com/mikker/FlickRing.app'

  app 'FlickRing.app'

  # Accessibility permission prompt
  postflight do
    accessibility_api_prompt = <<~EOS
      FlickRing requires Accessibility API permissions.
      Please follow these steps to enable it:
       1. Open System Preferences
       2. Go to Privacy & Security
       3. Select Accessibility from the right sidebar
       4. Click the + button on the bottom of the app list (you might be promted for the user's password)
       5. Select FlickRing and click "Open".
       6. You should see FlickRing now on the Accessibility list, with it's toggle ON.
       7. Quit FlickRing and reopen it again.
    EOS

    puts accessibility_api_prompt
  end

  # Zap files on uninstall
  zap trash: [
    "~/Library/Applications Scripts/com.brnbw.FlickRing",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.brnbw.flickring.sfl3",
    "~/Library/Containers/com.brnbw.FlickRing"
  ]

  uninstall script: {
              executable: "/usr/bin/tccutil",
              args:       ["reset", "Accessibility", "com.brnbw.FlickRing"],
              sudo:       true
            }
end
