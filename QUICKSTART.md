# Bookmode - Quick Start Guide

## Prerequisites

Before you begin, ensure you have:
- Mac with macOS Monterey or later
- Xcode 15.0 or later installed
- Physical iOS device running iOS 17.0 or later (Screen Time APIs don't work in simulator)
- Apple Developer account (free tier is sufficient for testing)

## Step 1: Clone and Open Project

```bash
git clone https://github.com/iwoj/Bookmode.git
cd Bookmode
open Bookmode.xcodeproj
```

## Step 2: Configure Project

1. Open the project in Xcode
2. Select the Bookmode target
3. Go to "Signing & Capabilities" tab
4. Select your development team
5. Xcode will automatically configure the bundle identifier if needed

## Step 3: Connect Your Device

1. Connect your iOS device via USB
2. Trust the device if prompted
3. In Xcode, select your device from the scheme dropdown (next to the Run button)

## Step 4: Build and Run

1. Press ⌘R or click the Run button
2. Xcode will build and install the app on your device
3. If you see a "Developer Mode" alert, enable it in Settings > Privacy & Security > Developer Mode

## Step 5: First Launch Setup

### Grant Permissions

1. **Notification Permission**: Tap "Allow" when prompted
   - This is required for receiving book reminders

2. **Screen Time Authorization**: 
   - Open the app and go to Settings tab
   - Tap "Request Authorization"
   - Follow the prompts to grant Screen Time access
   - This requires authenticating with Face ID/Touch ID/Passcode

### Add Your First Book

1. Go to the "Books" tab
2. Tap the "+" button
3. Enter book details:
   - Title: e.g., "The Lord of the Rings"
   - Author: e.g., "J.R.R. Tolkien"
   - Total Pages: e.g., "1200"
   - Current Page: e.g., "150" (optional)
   - Genre: e.g., "Fantasy" (optional)
4. Tap "Add"

### Select Social Media Apps to Monitor

1. Go to Settings tab
2. Tap "Select Social Media Apps"
3. Choose the apps you want to monitor (e.g., Twitter, Instagram, TikTok, Facebook)
4. Tap "Done"

## Step 6: Test the App

### Quick Test (Recommended)

1. Ensure you have at least one book added
2. Go to Settings tab
3. Scroll to "Testing" section
4. Tap "Simulate Doom Scrolling"
5. You should receive a notification within 1 second about one of your books

### Test with Real Usage

1. Use one of your selected social media apps for 5+ minutes continuously
2. The app will detect this and send you a notification
3. The notification will include a personalized message about one of your books

## Step 7: Optional - Configure AI Notifications

If you want AI-generated personalized notifications:

1. Get an OpenAI API key:
   - Visit https://platform.openai.com/
   - Create an account or sign in
   - Go to API Keys section
   - Create a new secret key and copy it

2. In Bookmode:
   - Go to Settings tab
   - Find "AI Configuration" section
   - Paste your API key in the secure field
   - Tap "Save API Key"

3. Future notifications will use AI-generated content based on your book details

**Note**: Without an API key, the app uses high-quality fallback prompts - AI is optional!

## Troubleshooting

### "Cannot Run on Device" Error
- Ensure device is running iOS 17.0 or later
- Check that device is unlocked and trusted
- Try unplugging and reconnecting the device

### Screen Time Authorization Fails
- Ensure device has Screen Time enabled in Settings > Screen Time
- Try restarting the device
- Make sure you complete the authentication (Face ID/Touch ID)

### No Notifications Appearing
1. Check notification permissions:
   - Settings app > Notifications > Bookmode > Allow Notifications
2. Try the test notification button in Settings
3. Ensure device is not in Do Not Disturb mode

### App Crashes on Launch
1. Clean build folder: Product > Clean Build Folder (⌘⇧K)
2. Restart Xcode
3. Delete app from device and reinstall
4. Check Console for error messages

### Monitoring Not Working
- Verify "Authorization Status" shows "Approved" in Settings
- Ensure apps are selected (shows count > 0)
- Remember: Only works on physical device, not simulator
- Try toggling monitoring off and on

## Understanding the App

### How It Works

1. **Background Monitoring**: Once authorized, the app monitors your usage of selected social media apps using Apple's Screen Time framework

2. **Doom Scrolling Detection**: When you've been using social media for 5+ minutes continuously, the app considers this "doom scrolling"

3. **Notification Trigger**: A notification is generated about one of your books to encourage you to take a reading break

4. **Smart Content**: Notifications include:
   - Book title and author
   - Your current progress
   - An engaging message to draw you back to reading

### App Structure

- **Books Tab**: Manage your reading list, track progress
- **Settings Tab**: Configure monitoring, test features, set up AI

### Privacy

- All data stays on your device
- Only you can see your books and reading progress
- The app only monitors apps you explicitly select
- No tracking or analytics
- OpenAI API (if used) only receives book title/author/progress for prompt generation

## Next Steps

Now that you're set up:

1. **Add More Books**: Build your reading list
2. **Update Progress**: Keep your reading progress current for relevant notifications
3. **Adjust Usage**: Notice how the notifications affect your social media habits
4. **Experiment**: Try the test features to see different notification styles

## Development Tips

### Viewing Logs

1. Open Console.app on your Mac
2. Connect your device
3. Filter for "Bookmode"
4. Run the app and watch for log messages

### Debugging

1. Set breakpoints in service classes to trace execution
2. Check `ActivityMonitorService.swift` for monitoring logic
3. Review `NotificationService.swift` for notification delivery
4. Examine `AIService.swift` for AI integration

### Making Changes

The codebase is organized into:
- `Models/`: Data structures (Book, BookManager)
- `Views/`: SwiftUI interface (BooksView, SettingsView, etc.)
- `Services/`: Business logic (ActivityMonitor, Notifications, AI)

Feel free to modify and extend!

## Need Help?

- Check `ARCHITECTURE.md` for detailed technical documentation
- Review code comments in service files
- Open an issue on GitHub
- Review Apple's Screen Time documentation: https://developer.apple.com/documentation/deviceactivity

## What's Next?

Once familiar with the app:
- Customize the doom scrolling threshold (currently 5 minutes)
- Add more notification variety
- Implement reading statistics
- Create book recommendations
- Add book cover images
- Integrate with book APIs

Happy reading! 📚
