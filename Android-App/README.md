# Android App

This directory contains the Flutter/Android application for the Automated Water Pump Controller.

## Structure

```
Android-App/
├── lib/                   # Dart source code
│   ├── main.dart         # App entry point
│   ├── screens/          # UI screens
│   ├── widgets/          # Reusable UI components
│   ├── models/           # Data models
│   ├── services/         # API and Bluetooth services
│   └── utils/            # Utility functions
├── assets/               # Images, icons, fonts
├── android/              # Android-specific configuration
├── ios/                  # iOS-specific configuration (if needed)
├── pubspec.yaml          # Dependencies and metadata
└── README.md             # This file
```

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with Flutter extension
- Android device or emulator

### Setup
1. Install Flutter SDK
2. Run `flutter doctor` to verify installation
3. Clone the repository
4. Navigate to the Android-App directory
5. Run `flutter pub get` to install dependencies

### Running the App
```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# For specific device
flutter run -d <device-id>
```

## Features
- [ ] Real-time water level monitoring
- [ ] Pump control interface
- [ ] Scheduling and automation
- [ ] Historical data visualization
- [ ] Push notifications
- [ ] Settings and configuration

## Dependencies
Add your main dependencies here:
- `http` - HTTP requests
- `bluetooth_serial` - Bluetooth communication
- `charts_flutter` - Data visualization
- `provider` - State management

## Architecture
- Using Provider for state management
- Repository pattern for data access
- Clean architecture principles

## Testing
```bash
# Run unit tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## Building for Release
```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS (if configured)
flutter build ios
```

## Contributing
Please refer to the main project's CONTRIBUTING.md for guidelines.

## Code Style
- Follow Flutter/Dart style guide
- Use meaningful variable and function names
- Comment complex logic
