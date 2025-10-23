# Bookmode - App Screenshots & UI Guide

This document describes the expected screens and user interface of the Bookmode app.

## Main Screens

### 1. Books Tab (Empty State)

When no books have been added yet:
- Large book icon (SF Symbol: `books.vertical`)
- "No Books Yet" title
- "Add your first book to get started" subtitle
- Prominent "Add Book" button

**Purpose**: Clear call-to-action for first-time users

### 2. Books Tab (With Books)

Displays two sections:

#### Currently Reading Section
- Shows books where `currentPage > 0` and `currentPage < totalPages`
- Each book row displays:
  - Book title (headline font)
  - Author name (subheadline, gray)
  - Progress bar showing percentage complete
  - "Page X of Y" indicator

#### All Books Section
- Shows all books in collection
- Same row format as Currently Reading
- Swipe-to-delete enabled
- Ordered by date added

**Navigation Bar**:
- Title: "My Books"
- "+" button in top-right to add new book

### 3. Add Book Sheet

Modal form with sections:

#### Book Information
- Title (required, text field)
- Author (required, text field)
- Genre (optional, text field)

#### Progress
- Total Pages (required, number pad)
- Current Page (optional, number pad)

#### Notes
- Multi-line text editor
- 100px height
- Optional field

**Navigation Bar**:
- Title: "Add Book"
- "Cancel" button (leading)
- "Add" button (trailing, disabled until valid)

**Validation**:
- "Add" button enabled only when title, author, and total pages are filled

### 4. Book Detail Sheet

Modal view showing:

#### Book Info Section (Read-only)
- Title
- Author
- Genre (if available)

#### Progress Section (Editable)
- Current Page (editable number field)
- Total Pages (read-only)
- Visual progress bar
- Percentage complete

#### Notes Section
- Multi-line text editor
- Editable
- 100px height

**Navigation Bar**:
- Title: "Book Details"
- "Cancel" button (leading)
- "Save" button (trailing)

**Behavior**:
- Tapping Save updates book and dismisses sheet
- Tapping Cancel dismisses without saving

### 5. Settings Tab

Form with multiple sections:

#### Screen Time Monitoring
- **Authorization Status** row:
  - Label: "Authorization Status"
  - Value: "Not Requested" / "Denied" / "Approved"
  - Color-coded: Orange / Red / Green

- **Request Authorization** button:
  - Only shown if not approved
  - Triggers iOS authorization flow

- **Select Social Media Apps** button:
  - Only shown if approved
  - Opens FamilyActivityPicker

- **Monitoring Active** toggle:
  - Read-only display
  - Shows current monitoring state

- **Selected Apps** count:
  - Small gray text
  - Shows number of apps selected

#### AI Configuration
- "OpenAI API Key" label (gray, caption)
- Secure text field for API key
- "Save API Key" button (disabled if empty)
- Explanation text about API usage

#### Notifications
- "Send Test Notification" button
- Explanation about enabling notifications in Settings

#### Testing
- "Simulate Doom Scrolling" button
  - Disabled if authorization not approved
- Explanation of test feature

#### About
- Version number (read-only)
- Doom Scrolling Threshold (read-only, "5 minutes")

**Navigation Bar**:
- Title: "Settings"

### 6. Family Activity Picker (System UI)

Native iOS sheet that appears when selecting apps:
- Search bar at top
- List of all installed apps
- Multi-select capability
- Selected apps show checkmark
- "Done" button in navigation bar

**Note**: This is provided by iOS, not custom UI

### 7. Notification

Local notification that appears on lock screen and notification center:

**Title**: "Time for a Reading Break!"

**Body**: One of:
- AI-generated personalized prompt (if API key configured)
- Fallback prompt like:
  - "Remember '[Title]'? You left off at page X. Time to find out what happens next!"
  - "Your book is calling! '[Title]' is waiting for you at page X."
  - "You're X% through '[Title]'. Let's keep that momentum going!"

**Actions**: Tap to open app

### 8. Authorization Dialogs (System UI)

#### Screen Time Authorization
- System dialog explaining what app will access
- Requires Face ID / Touch ID / Passcode
- "Allow" and "Don't Allow" options

#### Notification Permission
- Standard iOS notification permission dialog
- Appears on first launch
- "Allow" and "Don't Allow" options

## Color Scheme

The app uses iOS system colors for native appearance:

- **Primary**: System blue (default accent color)
- **Backgrounds**: System background colors (adapts to dark mode)
- **Text**: 
  - Primary: System label color
  - Secondary: System gray
- **Status Indicators**:
  - Green: Approved/active
  - Orange: Pending/not determined
  - Red: Denied/error

## Dark Mode Support

All screens automatically adapt to dark mode using system colors:
- Backgrounds invert appropriately
- Text remains legible
- Progress bars adjust
- System components (pickers, alerts) follow system appearance

## Accessibility

- All interactive elements have appropriate labels
- Dynamic Type support throughout
- VoiceOver compatibility
- Sufficient color contrast
- Clear focus indicators

## Animations

Subtle animations used:
- Sheet presentations (system default slide up)
- Row deletions (system default)
- Progress bar fills (smooth transitions)
- Navigation transitions (system default)

## Empty States

### No Books
- Large icon
- Explanatory text
- Call-to-action button

### No Currently Reading
- Section simply doesn't appear
- All books shown in "All Books" section

### No API Key
- Secure field shows placeholder
- Button to save is disabled until text entered

## Error States

### Authorization Denied
- Status shows "Denied" in red
- Monitoring cannot be started
- User directed to system Settings

### No Apps Selected
- Shows count of 0
- Monitoring won't detect anything
- User prompted to select apps

### Notification Permission Denied
- Test notification button still available
- Alert would appear if user tries to use it
- Directed to system Settings

## Loading States

- Form submission: Button becomes disabled briefly
- API calls: No explicit loading indicator (fast enough)
- App launch: Standard iOS launch screen

## UI/UX Principles

1. **Native Feel**: Uses standard iOS components
2. **Clear Hierarchy**: Important info is prominent
3. **Progressive Disclosure**: Advanced features in Settings
4. **Immediate Feedback**: Actions have clear results
5. **Error Prevention**: Validation before submission
6. **Familiar Patterns**: Standard iOS interactions

## Screenshot Checklist

When taking screenshots for App Store or documentation:

- [ ] Books tab (empty state)
- [ ] Books tab (with 3-4 books)
- [ ] Add book sheet
- [ ] Book detail sheet
- [ ] Settings tab (authorized)
- [ ] Settings tab (not authorized)
- [ ] Notification on lock screen
- [ ] Notification in notification center
- [ ] App selection picker (system UI)

## Testing UI

### Manual UI Testing Checklist

- [ ] All navigation works (tabs, sheets, buttons)
- [ ] Text fields accept input correctly
- [ ] Number pads appear for numeric fields
- [ ] Keyboard dismisses appropriately
- [ ] Swipe to delete works
- [ ] Progress bars show correct percentages
- [ ] Colors are correct for each state
- [ ] Dark mode looks good
- [ ] Large text sizes work (accessibility)
- [ ] VoiceOver announces correctly
- [ ] Animations are smooth
- [ ] Sheets dismiss correctly
- [ ] Alerts appear and dismiss
- [ ] Pickers work correctly

## Notes for Designers

If creating marketing materials or mockups:

1. Use SF Pro font (system font)
2. Follow iOS Human Interface Guidelines
3. Use standard iOS component sizes
4. Respect safe areas and margins
5. Show realistic book data (not Lorem Ipsum)
6. Include navigation bars and tab bars
7. Show status bar at top
8. Use appropriate device frames
9. Consider both light and dark mode
10. Show actual notification banner styles

## UI Changes from Feedback

(This section to be updated based on user testing)

Currently: Initial implementation, no user feedback yet

---

**Note**: Since this is a code-only implementation without a running simulator or device screenshots, this document describes the expected UI. To generate actual screenshots:

1. Run app on physical device
2. Use iOS screenshot feature (Volume Up + Side Button)
3. Or use Xcode's screenshot feature
4. Or use QuickTime Player screen recording

For App Store screenshots, use:
- iPhone 15 Pro Max (6.7" display)
- iPhone 15 Pro (6.1" display)
- iPad Pro (12.9" display)

In all three orientations:
- Portrait (required)
- Landscape (optional)
