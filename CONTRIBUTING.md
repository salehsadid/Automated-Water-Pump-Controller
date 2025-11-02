# Contributing to Automated Water Pump Controller

Thank you for your interest in contributing to the Automated Water Pump Controller project! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues
1. Check existing issues to avoid duplicates
2. Use the issue templates when available
3. Provide clear, detailed descriptions
4. Include steps to reproduce bugs
5. Add relevant labels and milestones

### Submitting Changes
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📋 Development Guidelines

### Code Standards

#### Hardware (KiCad/Eagle)
- Use clear, descriptive component names
- Follow consistent naming conventions
- Include proper documentation in schematics
- Maintain organized layer structure

#### Firmware (C++)
- Follow Arduino/ESP32 coding conventions
- Use camelCase for variables and functions
- Use UPPER_CASE for constants
- Comment complex logic thoroughly
- Include function documentation

```cpp
// Good example
const int PUMP_PIN = 2;
int waterLevel = 0;

/**
 * Reads water level from ultrasonic sensor
 * @return Water level in centimeters
 */
int readWaterLevel() {
    // Implementation here
    return waterLevel;
}
```

#### Mobile App (Flutter/Dart)
- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful widget and class names
- Implement proper error handling
- Write unit tests for business logic

```dart
// Good example
class WaterLevelService {
  Future<int> getWaterLevel() async {
    try {
      // Implementation here
      return waterLevel;
    } catch (e) {
      throw WaterLevelException('Failed to read water level: $e');
    }
  }
}
```

### Git Workflow

#### Branch Naming
- `feature/feature-name` - New features
- `bugfix/bug-description` - Bug fixes
- `hotfix/critical-issue` - Critical fixes
- `docs/documentation-update` - Documentation changes

#### Commit Messages
Follow the conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(firmware): add ultrasonic sensor support
fix(app): resolve bluetooth connection timeout
docs(hardware): update wiring diagram
```

### Testing Requirements

#### Hardware
- Document all component testing procedures
- Include photos/videos of working prototypes
- Verify all connections and safety measures

#### Firmware
- Write unit tests for critical functions
- Test on actual hardware when possible
- Document any hardware-specific requirements

#### Mobile App
- Unit tests for business logic (minimum 80% coverage)
- Widget tests for UI components
- Integration tests for critical user flows

### Pull Request Process

1. **Before Submitting**
   - Ensure all tests pass
   - Update documentation if needed
   - Rebase on latest develop branch
   - Follow the code style guidelines

2. **PR Description Template**
   ```markdown
   ## Description
   Brief description of changes

   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Documentation update
   - [ ] Refactoring

   ## Testing
   - [ ] Unit tests added/updated
   - [ ] Integration tests added/updated
   - [ ] Manual testing completed

   ## Screenshots (if applicable)
   Add screenshots for UI changes

   ## Related Issues
   Closes #issue_number
   ```

3. **Review Process**
   - At least one team member must review
   - All discussions must be resolved
   - CI/CD checks must pass
   - Documentation must be updated

## 🏗️ Project Structure Guidelines

### Hardware Directory
```
Hardware/
├── Schematics/           # Circuit diagrams
├── PCB/                  # PCB design files
├── Datasheets/          # Component datasheets
├── BOM.md               # Bill of Materials
└── README.md            # Hardware documentation
```

### Firmware Directory
```
Firmware/
├── src/                 # Main source files
├── include/             # Header files
├── test/                # Unit tests
├── platformio.ini       # Build configuration
└── README.md            # Firmware documentation
```

### Android-App Directory
```
Android-App/
├── lib/
│   ├── main.dart        # App entry point
│   ├── screens/         # UI screens
│   ├── widgets/         # Reusable components
│   ├── models/          # Data models
│   ├── services/        # Business logic
│   └── utils/           # Utilities
├── test/                # Unit tests
├── integration_test/    # Integration tests
└── README.md            # App documentation
```

## 🐛 Issue and Bug Reports

### Bug Report Template
```markdown
**Bug Description**
Clear description of the bug

**Steps to Reproduce**
1. Step 1
2. Step 2
3. Step 3

**Expected Behavior**
What should happen

**Actual Behavior**
What actually happens

**Environment**
- Hardware version:
- Firmware version:
- App version:
- Device/OS:

**Additional Context**
Screenshots, logs, or other relevant information
```

### Feature Request Template
```markdown
**Feature Description**
Clear description of the proposed feature

**Problem Statement**
What problem does this solve?

**Proposed Solution**
How should this be implemented?

**Alternatives Considered**
Other solutions you've considered

**Additional Context**
Mockups, examples, or other relevant information
```

## 📚 Documentation Standards

- Keep README files up to date
- Document all public APIs
- Include code examples where helpful
- Use clear, concise language
- Add diagrams for complex concepts

## 🎯 Development Environment Setup

### Required Tools
- **Git** - Version control
- **Hardware**: KiCad or Eagle CAD
- **Firmware**: PlatformIO or Arduino IDE
- **App**: Flutter SDK, Android Studio/VS Code

### Recommended Extensions (VS Code)
- PlatformIO IDE
- Flutter
- Dart
- GitLens
- Markdown All in One

## 🏆 Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes for significant contributions
- Project documentation

## 📞 Getting Help

- **GitHub Issues** - Bug reports and feature requests
- **GitHub Discussions** - General questions and ideas
- **Team Chat** - (Add your team communication channel)

## 📄 Code of Conduct

This project follows a code of conduct to ensure a welcoming environment for all contributors:

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Celebrate diverse perspectives

Thank you for contributing to the Automated Water Pump Controller project! 🚰⚡