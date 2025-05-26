# Homebrew Cask file for FlickRing

cask 'flickring' do
  version :latest # workaround to support the FlickRing-latest.zip build target
  # version "1.2.3"


  language "en", default: true do
    sha256 :no_check # workaround to support the FlickRing-latest.zip build target
    # This below would be ideal, since it guarantees the file integrity and security.
    # sha256 "a683b83736ce6800aaca53581519353acc315722eda9294d005404b805814c40"
    "en-US"
  end

  # Assuming flick-ring-updates.s3.amazonaws.com is owned and trusted by the project owner, this is needed to
  # work around the `sha256 :no_check` security audit.
  url 'https://flick-ring-updates.s3.amazonaws.com/FlickRing-latest.zip', verified: "flick-ring-updates.s3.amazonaws.com"
  name 'FlickRing'
  homepage 'https://github.com/mikker/FlickRing.app'

  auto_updates true

  app 'FlickRing.app'

  # Accessibility and Input Monitoring permission prompt
  postflight do
    accessibility_api_prompt = <<~EOS
      FlickRing requires both Accessibility API, Input Monitoring API permissions and a restart.

      A) To add Accessibility API permission:
       1. Open System Preferences
       2. Go to Privacy & Security
       3. Select Accessibility from the right sidebar
       4. Click the + button on the bottom of the app list (you might be promted for the user's password)
       5. Select FlickRing and click "Open".
       6. You should see FlickRing now on the Accessibility list, with it's toggle ON.

      B) To add Input Monitoring API permission:
       1. Open System Preferences
       2. Go to Privacy & Security
       3. Select Input Monitoring from the right sidebar
       4. Click the + button on the bottom of the app list (you might be promted for the user's password)
       5. Select FlickRing and click "Open".
       6. You should see FlickRing now on the Input Monitoring list, with it's toggle ON.

      C) If have run FlickRing before manually adding the permissions above, quit it and reopen it.

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

  uninstall script: {
              executable: "/usr/bin/tccutil",
              args:       ["reset", "ListenEvent", "com.brnbw.FlickRing"],
              sudo:       true
            }
end
