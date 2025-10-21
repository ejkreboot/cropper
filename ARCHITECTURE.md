# Application Flow

## User Interface Layout

```
┌─────────────────────────────────────────────────────────────────┐
│  Image Cropper                                            [_][□][X] │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────┐  ┌────────────────────────────┐  ┌────────┐ │
│  │ Aspect Ratio   │  │ Export Path (optional)     │  │ Export │ │
│  │ 1.0            │  │ /home/user/cropped.png     │  └────────┘ │
│  └────────────────┘  └────────────────────────────┘            │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │                                                             │ │
│ │                     Drop an image here                      │ │
│ │                            📷                               │ │
│ │                                                             │ │
│ │                                                             │ │
│ │                                                             │ │
│ │                                                             │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## After Dropping an Image

```
┌─────────────────────────────────────────────────────────────────┐
│  Image Cropper                                            [_][□][X] │
├─────────────────────────────────────────────────────────────────┤
│  ┌────────────────┐  ┌────────────────────────────┐  ┌────────┐ │
│  │ Aspect Ratio   │  │ Export Path (optional)     │  │ Export │ │
│  │ 1.77           │  │                            │  └────────┘ │
│  └────────────────┘  └────────────────────────────┘            │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ │
│ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ │
│ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ │
│ │ ░░░░░░░░░░  [IMAGE CONTENT]  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ │
│ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ │
│ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ │
│ │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘

(Image displayed, ready for selection)
```

## During Selection Drawing

```
┌─────────────────────────────────────────────────────────────────┐
│  Image Cropper                                            [_][□][X] │
├─────────────────────────────────────────────────────────────────┤
│  ┌────────────────┐  ┌────────────────────────────┐  ┌────────┐ │
│  │ Aspect Ratio   │  │ Export Path (optional)     │  │ Export │ │
│  │ 1.77           │  │                            │  └────────┘ │
│  └────────────────┘  └────────────────────────────┘            │
├─────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────────────────┐ │
│ │ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓┌──────────────────────────────────┐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓│ ●  SELECTED IMAGE CONTENT    ●   │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓│                                   │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓│                                   │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓└──────────────────────────────────┘▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓  ●                             ●  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ │ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │ │
│ └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘

Legend:
  ▓ = Dark semi-transparent overlay (non-selected area)
  ─ = Blue selection border
  ● = Blue corner handles
```

## State Flow Diagram

```
                           ┌─────────────┐
                           │   Initial   │
                           │   State     │
                           └──────┬──────┘
                                  │
                                  │ User drops image
                                  ▼
                           ┌─────────────┐
                           │   Image     │
                    ┌─────▶│   Loaded    │◀─────┐
                    │      └──────┬──────┘      │
                    │             │             │
                    │             │ User drags  │
                    │             │ on image    │
                    │             ▼             │
                    │      ┌─────────────┐      │
                    │      │  Selection  │      │
                    │      │   Active    │      │
                    │      └──────┬──────┘      │
                    │             │             │
                    │             │ User presses│
                    │             │ Enter or    │
                    │             │ clicks Export│
                    │             ▼             │
                    │      ┌─────────────┐      │
                    │      │  Exporting  │      │
                    │      └──────┬──────┘      │
                    │             │             │
                    │             │ Export      │
                    │             │ complete    │
                    │             ▼             │
                    │      ┌─────────────┐      │
                    └──────┤  Selection  ├──────┘
                           │   Cleared   │
                           └─────────────┘
                                  │
                                  │ User can draw
                                  │ new selection
                                  │ (loops back)
```

## Data Flow

```
┌─────────────┐
│ File Drop   │
└──────┬──────┘
       │
       │ File path
       ▼
┌─────────────────┐
│ Read file as    │
│ Uint8List       │
└──────┬──────────┘
       │
       │ Image data
       ▼
┌─────────────────┐     ┌──────────────┐
│ Display image   │────▶│ Cache display│
│ Calculate size  │     │ size         │
└─────────────────┘     └──────────────┘
       │
       │ User interaction
       ▼
┌─────────────────┐     ┌──────────────┐
│ Pan events      │────▶│ Update       │
│ (start/update/  │     │ selection    │
│  end)           │     │ rectangle    │
└─────────────────┘     └──────────────┘
       │
       │ Export triggered
       ▼
┌─────────────────┐
│ Decode image    │
│ (image package) │
└──────┬──────────┘
       │
       │ Decoded image
       ▼
┌─────────────────┐
│ Scale selection │
│ rect to original│
│ image coords    │
└──────┬──────────┘
       │
       │ Scaled rect
       ▼
┌─────────────────┐
│ Crop image      │
│ (img.copyCrop)  │
└──────┬──────────┘
       │
       │ Cropped image
       ▼
┌─────────────────┐
│ Encode image    │
│ (PNG or JPEG)   │
└──────┬──────────┘
       │
       │ Encoded bytes
       ▼
┌─────────────────┐
│ Write to file   │
└──────┬──────────┘
       │
       │ Success
       ▼
┌─────────────────┐
│ Show message &  │
│ Clear selection │
└─────────────────┘
```

## Key Interactions

### 1. Image Drop
```
User Action: Drag PNG/JPEG file onto window
    ↓
App Response: 
  - Validate file type
  - Read file as bytes
  - Display image
  - Focus window for keyboard input
```

### 2. Selection Drawing
```
User Action: Click and drag on image
    ↓
onPanStart:
  - Record start point
  - Set dragging flag
    ↓
onPanUpdate (continuous):
  - Calculate current rectangle
  - Apply aspect ratio if set
  - Constrain to image bounds
  - Update visual selection
    ↓
onPanEnd:
  - Clear dragging flag
  - Selection remains
```

### 3. Aspect Ratio Application
```
User enters aspect ratio (e.g., 1.77)
    ↓
During selection drawing:
  - Calculate current width and height
  - Calculate current ratio = width/height
  - If ratio ≠ target ratio:
      - If ratio > target: constrain width
      - If ratio < target: constrain height
  - Ensure result fits in image bounds
```

### 4. Export Process
```
User presses Enter or clicks Export
    ↓
Validation:
  - Check image loaded
  - Check selection exists
  - Check selection size > 0
    ↓
Coordinate Mapping:
  - Get original image dimensions
  - Calculate scale factors
  - Scale selection coordinates
    ↓
Image Processing:
  - Decode image data
  - Crop using scaled coordinates
  - Encode to target format
    ↓
File I/O:
  - Determine output path
  - Write encoded bytes
  - Show success message
    ↓
Cleanup:
  - Clear selection
  - Ready for next crop
```

## Coordinate Systems

### Display Coordinates
- Used for UI interaction
- Based on scaled/fitted image size
- Range: (0, 0) to (displayWidth, displayHeight)

### Original Coordinates
- Used for actual cropping
- Based on original image file
- Range: (0, 0) to (originalWidth, originalHeight)

### Mapping Formula
```
originalX = displayX × (originalWidth / displayWidth)
originalY = displayY × (originalHeight / displayHeight)
```

Example:
- Original image: 3000 × 2000 pixels
- Display size: 600 × 400 pixels
- Scale factors: 5.0 × 5.0
- Display selection: (100, 100, 200, 150)
- Original selection: (500, 500, 1000, 750)
