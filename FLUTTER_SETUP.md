# Flutter Setup Guide for Water Pump Controller

## Quick Setup Instructions

### 1. Install Flutter SDK

**Option A: Using Git (Recommended)**
```powershell
# Create a development directory
mkdir C:\development
cd C:\development

# Clone Flutter repository
git clone https://github.com/flutter/flutter.git -b stable

# Add Flutter to PATH
# Add C:\development\flutter\bin to your system PATH
```

**Option B: Download Manually**
1. Go to https://flutter.dev/docs/get-started/install/windows
2. Download the Flutter SDK zip file
3. Extract to `C:\development\flutter`
4. Add `C:\development\flutter\bin` to your system PATH

### 2. Add Flutter to System PATH

**Using PowerShell (as Administrator):**
```powershell
# Get current PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

# Add Flutter to PATH if not already present
if ($currentPath -notlike "*C:\development\flutter\bin*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;C:\development\flutter\bin", "Machine")
    Write-Host "Flutter added to PATH. Please restart your terminal."
}
```

**Using Windows Settings (Alternative):**
1. Open Windows Settings → System → About
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under System Variables, find and select "Path", then click "Edit"
5. Click "New" and add: `C:\development\flutter\bin`
6. Click OK and restart your terminal

### 3. Verify Installation

After restarting your terminal:
```powershell
flutter --version
flutter doctor
```

### 4. Install Dependencies

```powershell
# Navigate to the Android-App directory
cd "d:\GitHub\Automated-Water-Pump-Controller\Android-App"

# Get Flutter dependencies
flutter pub get

# Run the app
flutter run
```

## Prerequisites

- **Git**: Required for Flutter installation
- **Android Studio**: For Android development (optional for this project)
- **VS Code**: With Flutter extension (recommended)
- **Chrome**: For web development (optional)

## Troubleshooting

### If Flutter is not recognized after installation:
1. Restart your terminal/PowerShell
2. Restart VS Code
3. Check if Flutter is in your PATH: `echo $env:PATH`

### If you get dependency errors:
```powershell
flutter clean
flutter pub get
```

### For development without physical device:
- Use Chrome for web development: `flutter run -d chrome`
- Use Windows desktop: `flutter run -d windows`

## Next Steps

Once Flutter is installed:
1. Run `flutter doctor` to check for any issues
2. Navigate to the Android-App directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

The app includes mock data, so it will work immediately without needing the hardware connection.