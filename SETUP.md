# Setup Guide

This guide will help you set up and run the Image Cropper application.

## Prerequisites

### 1. Install Flutter SDK

#### Linux
```bash
# Download Flutter
cd ~
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz
tar xf flutter_linux_3.24.5-stable.tar.xz

# Add to PATH (add to ~/.bashrc or ~/.zshrc for persistence)
export PATH="$PATH:$HOME/flutter/bin"

# Verify installation
flutter --version
```

#### macOS
```bash
# Download Flutter
cd ~
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.24.5-stable.zip
unzip flutter_macos_3.24.5-stable.zip

# Add to PATH (add to ~/.bash_profile or ~/.zshrc)
export PATH="$PATH:$HOME/flutter/bin"

# Verify installation
flutter --version
```

#### Windows
1. Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
2. Extract the zip file
3. Add `flutter\bin` to your PATH environment variable
4. Verify with `flutter --version` in command prompt

### 2. Install Platform-Specific Requirements

#### Linux
```bash
# Install required dependencies
sudo apt-get update
sudo apt-get install -y \
  clang \
  cmake \
  ninja-build \
  pkg-config \
  libgtk-3-dev \
  liblzma-dev \
  libstdc++-12-dev

# Enable desktop support
flutter config --enable-linux-desktop
```

#### macOS
```bash
# Install Xcode from App Store
# Install Xcode command line tools
xcode-select --install

# Enable desktop support
flutter config --enable-macos-desktop
```

#### Windows
```bash
# Install Visual Studio 2022 with "Desktop development with C++" workload
# Enable desktop support
flutter config --enable-windows-desktop
```

### 3. Run Flutter Doctor

Check your Flutter installation:
```bash
flutter doctor -v
```

Resolve any issues reported by Flutter doctor.

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/ejkreboot/cropper.git
cd cropper
```

### 2. Get Dependencies

```bash
flutter pub get
```

This will download all required packages:
- desktop_drop
- image
- flutter_lints

### 3. Verify Setup

Run the analyzer to check for any issues:
```bash
flutter analyze
```

Run tests:
```bash
flutter test
```

## Running the Application

### Development Mode

#### Linux
```bash
flutter run -d linux
```

#### macOS
```bash
flutter run -d macos
```

#### Windows
```bash
flutter run -d windows
```

### List Available Devices

To see all available devices:
```bash
flutter devices
```

### Hot Reload

While the app is running in development mode:
- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

## Building for Production

### Linux

```bash
flutter build linux --release

# The built application will be in:
# build/linux/x64/release/bundle/

# To run the built app:
./build/linux/x64/release/bundle/cropper
```

### macOS

```bash
flutter build macos --release

# The built application will be in:
# build/macos/Build/Products/Release/cropper.app

# To run the built app:
open build/macos/Build/Products/Release/cropper.app
```

### Windows

```bash
flutter build windows --release

# The built application will be in:
# build/windows/runner/Release/

# To run the built app:
.\build\windows\runner\Release\cropper.exe
```

## Troubleshooting

### Issue: "flutter: command not found"

**Solution**: Make sure Flutter's bin directory is in your PATH:
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### Issue: "Desktop support not enabled"

**Solution**: Enable desktop support for your platform:
```bash
flutter config --enable-linux-desktop   # Linux
flutter config --enable-macos-desktop   # macOS
flutter config --enable-windows-desktop # Windows
```

### Issue: Build fails with "gtk-3.0 not found" (Linux)

**Solution**: Install GTK development libraries:
```bash
sudo apt-get install libgtk-3-dev
```

### Issue: Dependencies not downloading

**Solution**: Clear pub cache and try again:
```bash
flutter pub cache repair
flutter pub get
```

### Issue: App crashes on startup

**Solution**: 
1. Check flutter doctor: `flutter doctor -v`
2. Clean and rebuild:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

### Issue: Drag and drop not working

**Solution**: Make sure you're running on a desktop platform (not web or mobile emulator). Desktop drag-and-drop requires native desktop support.

## Using the Application

Once the application is running:

1. **Load an Image**
   - Drag a PNG or JPEG file from your file manager
   - Drop it onto the application window

2. **Set Aspect Ratio (Optional)**
   - Enter a number in the "Aspect Ratio" field
   - Examples: 1.0 (square), 1.77 (16:9), 0.5625 (9:16)

3. **Set Export Path (Optional)**
   - Enter a full path where you want to save the cropped image
   - Leave empty to auto-generate a path next to the original image

4. **Draw Selection**
   - Click and drag on the image to create a selection box
   - The selection will maintain the aspect ratio if specified

5. **Export**
   - Press Enter OR click the "Export" button
   - A success message will show the export path
   - The selection will be cleared for next crop

6. **Additional Crops**
   - Draw a new selection box and export again
   - Each export creates a separate file

## Development Tips

### Hot Reload
Make code changes and press `r` in the terminal for instant updates without restarting.

### Debug Mode
Add breakpoints in your IDE (VS Code, Android Studio) and run in debug mode for step-through debugging.

### Performance Profiling
Run with performance overlay:
```bash
flutter run --profile
```

### Logging
Add print statements or use the Dart DevTools:
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

## Next Steps

- Read `IMPLEMENTATION.md` for technical details
- Read `example/README.md` for testing scenarios
- Check the `README.md` for feature overview

## Support

For issues or questions:
- Open an issue on GitHub: https://github.com/ejkreboot/cropper/issues
- Check Flutter documentation: https://docs.flutter.dev/
