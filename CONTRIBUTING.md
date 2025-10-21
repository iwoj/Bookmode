# Contributing to Bookmode

Thank you for your interest in contributing to Bookmode! This document provides guidelines and instructions for contributing to the project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/Bookmode.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test thoroughly on a physical iOS device
6. Commit your changes with clear, descriptive messages
7. Push to your fork: `git push origin feature/your-feature-name`
8. Open a Pull Request

## Development Setup

See [QUICKSTART.md](QUICKSTART.md) for detailed setup instructions.

### Requirements
- macOS with Xcode 15.0+
- Physical iOS device running iOS 17.0+
- Apple Developer account (free tier works)

## Code Style Guidelines

### Swift Style

- Use Swift naming conventions (camelCase for variables/functions, PascalCase for types)
- Include meaningful comments for complex logic
- Keep functions focused and single-purpose
- Use `// MARK: -` to organize code sections in larger files

### SwiftUI Best Practices

- Use `@State` for view-local state
- Use `@StateObject` for creating observable objects
- Use `@EnvironmentObject` for dependency injection
- Extract reusable components into separate views
- Use view modifiers for common styling

### Architecture Patterns

- **Models**: Keep data structures simple and Codable
- **Views**: UI only, minimal business logic
- **Services**: Business logic and external integrations
- **Managers**: State management and persistence

## Areas for Contribution

### High Priority

1. **Device Activity Monitor Extension**
   - Create proper app extension for background monitoring
   - Implement DeviceActivityMonitor protocol
   - Handle events when app is terminated

2. **Enhanced Persistence**
   - Migrate from UserDefaults to Core Data or SwiftData
   - Add support for book cover images
   - Implement reading history and statistics

3. **Testing**
   - Add unit tests for models and services
   - Add UI tests for critical flows
   - Mock Screen Time APIs for simulator testing

4. **Accessibility**
   - Add VoiceOver labels
   - Improve Dynamic Type support
   - Add accessibility identifiers

### Medium Priority

5. **Book API Integration**
   - Google Books API for book lookup
   - ISBN scanning with camera
   - Automatic cover image download

6. **Enhanced AI Features**
   - Support for other AI providers (Anthropic, Google)
   - Context-aware prompts based on time of day
   - Learning user preferences

7. **Customization**
   - Adjustable doom scrolling threshold
   - Custom notification schedules
   - Per-app thresholds

8. **Statistics Dashboard**
   - Time saved from social media
   - Reading streaks
   - Progress charts

### Low Priority

9. **Social Features**
   - Share reading progress
   - Reading challenges
   - Book clubs

10. **UI Enhancements**
    - Dark mode optimization
    - Custom themes
    - Animations and transitions
    - iPad-optimized layouts

## Testing Requirements

### Before Submitting a PR

1. **Build Successfully**: Ensure code compiles without errors or warnings
2. **Test on Device**: Must test on physical iOS device (Screen Time doesn't work in simulator)
3. **Core Functionality**: Verify these work:
   - Adding/editing/deleting books
   - Screen Time authorization
   - App selection
   - Notification delivery
   - Doom scrolling simulation

4. **No Regressions**: Ensure existing features still work
5. **Code Review**: Self-review your changes before submitting

### Testing Checklist

- [ ] App builds without warnings
- [ ] Tested on physical device (iOS 17.0+)
- [ ] Screen Time authorization works
- [ ] Book CRUD operations work
- [ ] Notifications appear correctly
- [ ] AI integration works (with and without API key)
- [ ] No crashes or freezes
- [ ] UI is responsive and intuitive
- [ ] Code follows project style guidelines
- [ ] Comments added for complex logic

## Pull Request Guidelines

### PR Title Format

Use clear, descriptive titles:
- `Add: [Feature name]` - New features
- `Fix: [Bug description]` - Bug fixes
- `Improve: [What was improved]` - Enhancements
- `Refactor: [What was refactored]` - Code improvements
- `Docs: [What was documented]` - Documentation changes

### PR Description

Include:
1. **What**: What changes were made?
2. **Why**: Why were these changes necessary?
3. **How**: How were they implemented?
4. **Testing**: How was this tested?
5. **Screenshots**: For UI changes, include before/after screenshots
6. **Breaking Changes**: Note any breaking changes

### Example PR Description

```markdown
## What
Added support for book cover images from Google Books API

## Why
Users requested visual book representation to make the app more engaging

## How
- Integrated Google Books API in new `BookAPIService.swift`
- Added `coverImageURL` property to Book model
- Updated BooksView to display cover images
- Added image caching for performance

## Testing
- Tested with 20+ books
- Verified images load correctly
- Tested offline behavior (cached images work)
- No performance impact on scrolling

## Screenshots
[Before] [After]

## Breaking Changes
None - existing books continue to work without images
```

## Code Review Process

1. **Automated Checks**: CI will run (when configured)
2. **Maintainer Review**: A maintainer will review your code
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, your PR will be merged

## Common Issues and Solutions

### Screen Time Authorization Fails
- Ensure testing on physical device
- Check device has Screen Time enabled
- Try restarting device

### Notification Not Appearing
- Check notification permissions in iOS Settings
- Verify test notification works
- Check Console.app for errors

### Build Errors with Xcode
- Clean build folder (⌘⇧K)
- Delete DerivedData folder
- Restart Xcode

## Privacy Considerations

When contributing, ensure:
- No user data is sent to external servers (except optional OpenAI API)
- API keys are stored securely
- Users are informed of data usage
- Screen Time data is handled according to Apple's guidelines
- No analytics or tracking added without user consent

## Documentation

When adding new features:
- Update README.md if user-facing
- Update ARCHITECTURE.md for technical changes
- Add inline code comments
- Update QUICKSTART.md if setup changes

## Questions?

- Open an issue for questions
- Check existing documentation first
- Review Apple's Screen Time documentation
- Check Stack Overflow for iOS development questions

## Community Guidelines

- Be respectful and constructive
- Help others learn
- Share knowledge
- Celebrate successes
- Learn from mistakes

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Bookmode! Your efforts help others break free from doom scrolling and return to their books. 📚
