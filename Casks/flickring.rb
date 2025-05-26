# Homebrew Cask file for FlickRing

cask 'flickring' do
  version :latest # We'll use the latest version

  if Hardware::Mac.older?
    sha256 'a683b83736ce6800aaca53581519353acc315722eda9294d005404b805814c40'
  end

  url 'https://flick-ring-updates.s3.amazonaws.com/FlickRing-latest.zip'
  name 'FlickRing'
  homepage 'https://github.com/mikker/FlickRing.app'

  app 'FlickRing.app', target: '/Applications'

  # Accessibility permission prompt
  postflight do
    accessibility_api_prompt = <<~EOS
      FlickRing requires Accessibility API permissions.
      Please follow these steps to enable it:
       1. Open System Preferences
       2. Go to Security & Privacy > Privacy tab
       3. Select Accessibility from the left sidebar
       4. Click the lock icon to make changes and enter your password
       5. Add FlickRing by selecting it from the list
    EOS

    puts accessibility_api_prompt
  end

  # Zap files on uninstall
  zap trash: [
    '~/Library/Applications Scripts/com.brnbw.FlickRing',
    '~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.brnbw.flickring.sfl3',
    '~/Library/Containers/com.brnbw.FlickRing'
  ]
end
