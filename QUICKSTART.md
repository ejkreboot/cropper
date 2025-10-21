# Quick Start Guide

Get the Image Cropper app running in 5 minutes!

## Prerequisites

You need Flutter SDK installed. If you don't have it:

**Linux:**
```bash
cd ~
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz
tar xf flutter_linux_3.24.5-stable.tar.xz
export PATH="$PATH:$HOME/flutter/bin"
flutter doctor
```

**macOS/Windows:** See [SETUP.md](SETUP.md) for detailed instructions.

## Installation

```bash
# Clone the repo
git clone https://github.com/ejkreboot/cropper.git
cd cropper

# Get dependencies
flutter pub get

# Run the app
flutter run -d linux    # Change to 'macos' or 'windows' as needed
```

## Usage

1. **Drop an image** - Drag a PNG or JPEG file onto the window
2. **Set aspect ratio** (optional) - Enter a number like `1.77` for 16:9
3. **Draw selection** - Click and drag on the image
4. **Export** - Press Enter or click Export button
5. **Repeat** - Draw another selection box for more crops

## Common Aspect Ratios

- `1.0` - Square (1:1)
- `1.77` - Widescreen (16:9)
- `1.33` - Standard (4:3)
- `0.5625` - Portrait (9:16)
- Leave empty for free-form selection

## Troubleshooting

**"flutter: command not found"**
```bash
export PATH="$PATH:$HOME/flutter/bin"
```

**"Desktop support not enabled"**
```bash
flutter config --enable-linux-desktop   # or macos/windows
```

**Dependencies won't download**
```bash
flutter pub cache repair
flutter pub get
```

## Need Help?

- 📖 Full setup guide: [SETUP.md](SETUP.md)
- 🏗️ Architecture details: [ARCHITECTURE.md](ARCHITECTURE.md)
- 🔧 Implementation: [IMPLEMENTATION.md](IMPLEMENTATION.md)
- ✅ Testing guide: [example/README.md](example/README.md)

## Features at a Glance

✅ Drag and drop images  
✅ Interactive selection box  
✅ Aspect ratio constraints  
✅ Custom export paths  
✅ Keyboard shortcut (Enter)  
✅ Multiple exports  
✅ Visual selection overlay  
✅ Auto-generated file names  

Enjoy cropping! 🎨✂️
