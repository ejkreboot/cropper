# cropper
Crop photos quickly but interactively

A Flutter desktop application that allows users to:
- Drop an image onto the app
- Draw a selection box over the image with configurable aspect ratio
- Export the selected portion of the image
- Press Enter or click Export button to save the cropped image
- Draw multiple selection boxes for additional exports

## Features

- **Drag and Drop**: Drop PNG or JPEG images directly onto the application
- **Interactive Selection**: Click and drag to create a selection box over the image
- **Aspect Ratio Control**: Specify the aspect ratio (width/height) for the selection box
  - Enter 1.0 for a square selection
  - Enter 1.77 for 16:9 aspect ratio
  - Enter 0.5625 for 9:16 (portrait) aspect ratio
  - Leave empty for free-form selection
- **Custom Export Path**: Optionally specify where to save the cropped image
  - If not specified, saves next to original with timestamp
- **Keyboard Shortcut**: Press Enter to quickly export the current selection
- **Visual Feedback**: Semi-transparent overlay shows selected vs non-selected areas
- **Multiple Exports**: After exporting, draw a new selection box for additional crops

## Requirements

- Flutter SDK (3.0.0 or higher)
- Desktop platform (Windows, macOS, or Linux)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/ejkreboot/cropper.git
cd cropper
```

2. Get Flutter dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d linux   # For Linux
flutter run -d macos   # For macOS
flutter run -d windows # For Windows
```

## Usage

1. Launch the application
2. Drag and drop an image file (PNG or JPEG) onto the window
3. (Optional) Enter an aspect ratio in the "Aspect Ratio" field
4. (Optional) Enter a custom export path in the "Export Path" field
5. Click and drag on the image to create a selection box
6. Press Enter or click the "Export" button to save the cropped image
7. Draw another selection box to export additional crops

## Development

To build the application:

```bash
flutter build linux   # For Linux
flutter build macos   # For macOS
flutter build windows # For Windows
```

## License

This project is open source and available under the MIT License.
