# Implementation Details

## Architecture

The cropper application is built using Flutter with the following architecture:

### Main Components

1. **CropperApp** - Root application widget that sets up MaterialApp with theme
2. **CropperHomePage** - Main stateful widget that manages the application state
3. **ImageCropWidget** - Widget responsible for displaying the image and handling selection
4. **SelectionOverlayPainter** - Custom painter that draws the selection overlay and handles

### Key Features Implementation

#### 1. Drag and Drop
- Uses `desktop_drop` package for native desktop drag-and-drop support
- `DropTarget` widget wraps the main content area
- Accepts PNG and JPEG files only
- Reads dropped files as `Uint8List` for display

#### 2. Selection Box Drawing
- Uses `GestureDetector` with `onPanStart`, `onPanUpdate`, and `onPanEnd` callbacks
- Tracks drag start point and current point to calculate selection rectangle
- Constrains selection to image boundaries using `_constrainPoint()`
- Updates selection rectangle in real-time as user drags

#### 3. Aspect Ratio Constraint
- User enters desired aspect ratio (width/height) in text field
- During pan update, if aspect ratio is set:
  - Calculates current ratio of selection
  - Adjusts width or height to match target ratio
  - Ensures adjusted dimensions don't exceed image bounds
- Allows free-form selection when aspect ratio is not set or invalid

#### 4. Visual Feedback
- Uses `CustomPaint` with `SelectionOverlayPainter` to draw:
  - Semi-transparent black overlay on non-selected areas (0.5 opacity)
  - Blue border around selection rectangle
  - Blue circular handles at four corners
- Selected area remains clear showing the original image

#### 5. Export Functionality
- **Export Button**: Triggers `_exportSelection()` method
- **Enter Key**: `KeyboardListener` captures Enter key press and triggers export
- Export process:
  1. Decodes image data using `image` package
  2. Calculates scale factor between display size and original image size
  3. Scales selection rectangle to original image coordinates
  4. Crops image using `img.copyCrop()`
  5. Encodes to PNG or JPEG based on file extension
  6. Saves to specified path or generates default path with timestamp
  7. Shows success message and clears selection

#### 6. Multiple Exports
- After successful export, selection is cleared (`_selectionRect = null`)
- User can immediately draw a new selection box
- Each export is independent and saves to a separate file

### State Management

State is managed in `_CropperHomePageState`:
- `_imageData`: Raw image bytes for display
- `_imagePath`: Original file path for generating default export names
- `_selectionRect`: Current selection rectangle (null when no selection)
- `_dragStart`: Start point of current drag operation
- `_isDragging`: Boolean flag for drag state
- `_aspectRatio`: Parsed aspect ratio value (null if not set)
- `_cachedDisplaySize`: Cached display size for export calculations

### Display Size Handling

The application handles different image sizes and aspect ratios:
1. `LayoutBuilder` provides available container size
2. `FutureBuilder` loads image info to get original dimensions
3. Calculates display size maintaining image aspect ratio
4. Centers image in available space
5. Caches display size for accurate export coordinate mapping

### Coordinate Mapping

Selection coordinates are in display space, but export needs original image space:
- Display size = `(displayWidth, displayHeight)`
- Original size = `(imageWidth, imageHeight)`
- Scale factors: `scaleX = imageWidth / displayWidth`, `scaleY = imageHeight / displayHeight`
- Export rect = selection rect × scale factors

## Dependencies

### Production Dependencies
- **flutter**: Core Flutter framework
- **desktop_drop** (^0.4.4): Native desktop drag-and-drop support
- **image** (^4.1.3): Image encoding/decoding and manipulation

### Dev Dependencies
- **flutter_test**: Flutter testing framework
- **flutter_lints** (^3.0.0): Recommended lints for Flutter

## Platform Support

The application is designed for desktop platforms:
- ✅ Linux (includes full CMake configuration)
- ✅ macOS (requires Flutter SDK to generate platform files)
- ✅ Windows (requires Flutter SDK to generate platform files)

Mobile platforms (iOS/Android) are not supported as they don't have native drag-and-drop for files.

## Error Handling

The application handles several error cases:
- Invalid file type (not PNG/JPEG) - shows error message
- Failed to load image - shows error with exception details
- Failed to decode image - shows error message
- Selection too small (< 1px) - shows error message
- Failed to export - shows error with exception details

## User Experience

### Visual Design
- Clean Material Design 3 interface
- Blue color scheme
- Semi-transparent overlays for better visibility
- Clear visual feedback for selection
- Informative error and success messages

### Workflow
1. Drop image onto window
2. (Optional) Set aspect ratio
3. (Optional) Set export path
4. Draw selection box
5. Press Enter or click Export
6. See success message
7. Draw another selection for more exports

### Keyboard Shortcuts
- **Enter**: Export current selection

## Testing

The `test/widget_test.dart` file includes:
- Smoke test verifying app launches
- Widget existence tests for UI elements
- Tests for aspect ratio field
- Tests for export path field
- Tests for export button

To run tests:
```bash
flutter test
```

## Building

To build the application:

### Linux
```bash
flutter build linux
# Output: build/linux/x64/release/bundle/
```

### macOS
```bash
flutter build macos
# Output: build/macos/Build/Products/Release/
```

### Windows
```bash
flutter build windows
# Output: build/windows/runner/Release/
```

## Future Enhancements

Potential improvements that could be added:
- Resize selection by dragging handles
- Move selection without resizing
- Zoom in/out on image
- Rotate image before cropping
- Batch processing multiple images
- Preset aspect ratios (16:9, 4:3, 1:1, etc.)
- Undo/redo functionality
- Recent images list
- Crop preview window
- Support for more image formats (GIF, BMP, TIFF)
