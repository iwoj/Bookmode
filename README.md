# Bookmode

An iOS app that helps you break free from doom scrolling on social media by sending you personalized notifications about your books.

## Features

- **Screen Time Integration**: Uses Apple's Screen Time APIs to monitor social media usage
- **Device Activity Monitor**: Detects when you've been scrolling for more than 5 minutes
- **Smart Notifications**: Sends AI-generated personalized prompts about your books
- **Book Management**: Track multiple books, progress, and notes
- **GenAI Integration**: Optional OpenAI integration for creative, personalized notifications
- **Background Monitoring**: Runs in the background to catch doom scrolling in real-time

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Screen Time authorization
- Optional: OpenAI API key for enhanced notifications

## Setup

1. Clone the repository
2. Open `Bookmode.xcodeproj` in Xcode
3. Build and run on a physical iOS device (Screen Time features require a real device)

## Usage

### Adding Books

1. Open the app and tap the "+" button
2. Enter book details (title, author, total pages, current page)
3. Add optional notes and genre information

### Configuring Screen Time Monitoring

1. Go to the Settings tab
2. Tap "Request Authorization" to grant Screen Time access
3. Select social media apps you want to monitor
4. The app will now monitor your usage and send notifications after 5 minutes of continuous scrolling

### AI-Powered Notifications (Optional)

1. Get an OpenAI API key from https://platform.openai.com/
2. In Settings, enter your API key
3. The app will generate personalized, engaging notifications about your books

If no API key is provided, the app uses built-in fallback prompts.

## Architecture

### Models
- `Book.swift`: Core data model for books
- `BookManager.swift`: Manages book collection and persistence

### Views
- `BooksView.swift`: Main book list and details
- `AddBookView.swift`: Form for adding new books
- `SettingsView.swift`: Configuration and monitoring controls
- `ContentView.swift`: Tab navigation container

### Services
- `ActivityMonitorService.swift`: Screen Time and Device Activity monitoring
- `NotificationService.swift`: Local notification management
- `AIService.swift`: OpenAI integration for generating book prompts

## Privacy

This app:
- Stores all data locally on your device
- Only monitors apps you explicitly select
- Does not send usage data to any servers
- API key is stored securely in UserDefaults
- Complies with Apple's Screen Time privacy guidelines

## Background Modes

The app uses the following background modes:
- `processing`: For scheduled monitoring checks
- `remote-notification`: For notification delivery

## Entitlements

Required entitlements:
- `com.apple.developer.family-controls`: Access to Screen Time data
- `com.apple.developer.device-activity`: Monitor device activity
- `com.apple.developer.managed-settings`: Access app usage settings

## Testing

To test the app without waiting for actual doom scrolling:
1. Add a book in the Books tab
2. Go to Settings tab
3. Tap "Simulate Doom Scrolling"
4. You'll receive a notification about one of your books

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT License.
