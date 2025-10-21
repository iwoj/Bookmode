# Bookmode Architecture

## Overview

Bookmode is an iOS app designed to help users break their social media doom scrolling habit by sending timely notifications about their books. The app leverages Apple's Screen Time APIs, Device Activity Monitor, and Background Modes to detect extended social media usage and intervene with personalized book recommendations.

## Core Components

### 1. Screen Time & Device Activity Integration

#### ActivityMonitorService.swift
The `ActivityMonitorService` is the heart of the app's monitoring capabilities. It:

- Uses `FamilyControls` framework to request authorization for Screen Time data
- Leverages `DeviceActivity` framework to monitor app usage patterns
- Configures a monitoring schedule that runs 24/7
- Defines a "doom scrolling threshold" of 5 minutes (300 seconds)
- Creates device activity events that trigger when users exceed the threshold

**Key Features:**
- Authorization management through `AuthorizationCenter`
- App selection via `FamilyActivityPicker` (requires iOS 17.0+)
- Event-based monitoring with configurable thresholds
- Integration with notification and book management systems

**Limitations:**
- Requires real iOS device (simulator doesn't support Screen Time)
- User must grant Screen Time authorization
- Selected apps are monitored only when explicitly chosen

### 2. Book Management

#### Book.swift
Data model representing a book with properties:
- Basic info: title, author, genre
- Progress tracking: currentPage, totalPages, calculated progress percentage
- Metadata: dateAdded, lastRead, notes
- Computed properties for progress calculation and completion status

#### BookManager.swift
Observable object managing the book collection:
- CRUD operations for books (Create, Read, Update, Delete)
- Local persistence using UserDefaults with JSON encoding
- Query methods for filtering currently reading books
- Random book selection for notifications

### 3. Notification System

#### NotificationService.swift
Handles all notification-related functionality:
- Creates and schedules local notifications
- Integrates with AIService for content generation
- Provides test notification capability
- Manages notification permissions and delivery

**Notification Trigger:**
When doom scrolling is detected → generates notification → schedules immediate delivery

### 4. AI Integration

#### AIService.swift
Optional OpenAI integration for enhanced notifications:
- Connects to OpenAI GPT-3.5-turbo API
- Generates personalized, contextual book prompts
- Includes intelligent fallback system with 8+ pre-written prompts
- Secure API key storage in UserDefaults

**Prompt Engineering:**
The service sends context about:
- Book title and author
- Current progress (page X of Y)
- Request for brief, engaging content (max 100 characters)
- Goal: Encourage transition from social media to reading

**Fallback Prompts:**
When API is unavailable or not configured, uses varied, engaging prompts like:
- Progress-based: "You're X% through [title]. Let's keep that momentum going!"
- Curiosity-driven: "Remember [title]? You left off at page X. Time to find out what happens next!"
- Comparative: "Social media will still be here. Your book adventure won't wait!"

### 5. User Interface

#### ContentView.swift
Main container with TabView:
- Books tab: View and manage reading list
- Settings tab: Configure monitoring and API

#### BooksView.swift
Primary book management interface:
- List view showing all books
- Separate section for "Currently Reading"
- Progress indicators and page counts
- Swipe-to-delete functionality
- Detail view for updating progress and notes

#### AddBookView.swift
Form-based interface for adding new books:
- Required fields: title, author, total pages
- Optional fields: current page, genre, notes
- Input validation before submission
- Keyboard handling for numeric inputs

#### SettingsView.swift
Configuration and testing interface:
- Screen Time authorization status and request button
- App selection via FamilyActivityPicker
- OpenAI API key configuration
- Test notification button
- Doom scrolling simulator for testing

## Data Flow

### Normal Operation Flow

1. **App Launch**
   - BookmodeApp initializes all services
   - Requests notification permissions
   - Loads saved books from UserDefaults
   - Starts activity monitoring if authorized

2. **User Adds Books**
   - User enters book details via AddBookView
   - BookManager persists to UserDefaults
   - Books appear in BooksView

3. **Background Monitoring**
   - ActivityMonitorService monitors selected social media apps
   - DeviceActivity tracks usage time
   - When threshold reached (5 minutes), event triggers

4. **Notification Generation**
   - Event handler calls `handleDoomScrollingDetected()`
   - Selects random book from currently reading or all books
   - AIService generates personalized prompt (or uses fallback)
   - NotificationService schedules and delivers notification

5. **User Interaction**
   - User receives notification on device
   - Tapping notification opens app (can be extended for direct book view)
   - User ideally puts down phone and picks up book

### Testing Flow

1. User can simulate doom scrolling via Settings
2. Triggers notification immediately without waiting for actual usage
3. Allows verification of notification content and delivery

## Technical Considerations

### iOS Requirements

- **Minimum iOS Version:** 17.0
  - Required for modern Screen Time APIs
  - DeviceActivity and FamilyControls frameworks
  - SwiftUI features used throughout

- **Device Requirement:** Physical iOS device
  - Screen Time features unavailable in simulator
  - Testing must be done on real hardware

### Permissions & Entitlements

**Required Entitlements (Bookmode.entitlements):**
```xml
com.apple.developer.family-controls
com.apple.developer.device-activity
com.apple.developer.managed-settings
```

**Info.plist Usage Descriptions:**
- `NSFamilyControlsUsageDescription`: Explains Screen Time monitoring purpose
- `NSUserTrackingUsageDescription`: Required for Screen Time access

**User Permissions:**
- Screen Time authorization via AuthorizationCenter
- Local notification permissions via UNUserNotificationCenter

### Background Modes

**Configured in Info.plist:**
- `processing`: For background monitoring tasks
- `remote-notification`: For notification delivery

**Note:** While configured, the DeviceActivity framework handles most background operations automatically.

### Privacy & Security

- All data stored locally on device
- No analytics or tracking
- User explicitly selects which apps to monitor
- API key stored in UserDefaults (in production, should use Keychain)
- No data sent to external servers except OpenAI API (optional)
- Complies with Apple's Screen Time privacy guidelines

## Extensibility

### Future Enhancements

1. **Device Activity Monitor Extension**
   - Create app extension to handle events in true background
   - More reliable monitoring even when app is terminated
   - Better separation of concerns

2. **Enhanced Persistence**
   - Move from UserDefaults to Core Data or SwiftData
   - Support for book covers and images
   - Reading statistics and history

3. **Social Features**
   - Reading challenges
   - Share progress with friends
   - Book recommendations

4. **Advanced AI Features**
   - Context-aware prompts based on time of day
   - Learning user preferences
   - Integration with book APIs (Goodreads, Google Books)

5. **Customization**
   - Adjustable doom scrolling threshold
   - Custom notification schedules
   - App-specific thresholds

6. **Analytics**
   - Time saved from social media
   - Pages read correlation
   - Usage patterns

## Known Limitations

1. **Screen Time Authorization**
   - Cannot be automated; requires user interaction
   - If denied, app's core functionality is limited
   - Re-authorization requires system settings

2. **Background Execution**
   - iOS may limit background activity to preserve battery
   - Monitoring may not be instantaneous
   - System can delay or throttle notifications

3. **App Selection**
   - Must use Apple's FamilyActivityPicker
   - Cannot programmatically pre-select apps
   - User must manually choose each app

4. **API Costs**
   - OpenAI API usage incurs costs
   - No rate limiting implemented
   - Users responsible for their API usage

5. **Simulator Testing**
   - Screen Time features unavailable
   - Must test on physical device
   - Increases development friction

## Development Guidelines

### Building the App

1. Open `Bookmode.xcodeproj` in Xcode 15.0+
2. Select a physical iOS device running iOS 17.0+
3. Configure signing team (automatic signing recommended)
4. Build and run (⌘R)

### Testing

1. **Initial Setup**
   - Add at least one book via Books tab
   - Request Screen Time authorization in Settings
   - Select social media apps to monitor

2. **Quick Test**
   - Use "Simulate Doom Scrolling" button in Settings
   - Verify notification appears
   - Check notification content

3. **Real Usage Test**
   - Use selected social media apps for 5+ minutes
   - Wait for notification
   - Verify timing and content

### Code Style

- SwiftUI for all views
- Observable objects for state management
- Async/await for asynchronous operations
- Clear separation of concerns (Models, Views, Services)
- Comprehensive comments in service classes

## Troubleshooting

### No Notifications Appearing
1. Check notification permissions in iOS Settings
2. Verify Screen Time authorization granted
3. Ensure books are added to library
4. Try test notification button

### Monitoring Not Working
1. Verify authorization status is "Approved"
2. Check apps are selected in picker
3. Confirm running on physical device, not simulator
4. Review Console logs for error messages

### AI Notifications Not Personalized
1. Verify API key is entered in Settings
2. Check API key validity with OpenAI
3. Review Console for API error messages
4. Fallback prompts will be used if API fails

## Conclusion

Bookmode demonstrates a practical application of iOS Screen Time APIs to create a behavior modification tool. By combining device activity monitoring, intelligent notifications, and optional AI enhancement, it provides users with a gentle but effective nudge away from doom scrolling and back to their reading goals.

The architecture is designed to be extensible while maintaining simplicity and user privacy. All core functionality works without external dependencies, with AI enhancement available as an optional upgrade.
