# Example Usage

This directory contains example usage instructions for the cropper application.

## Testing the Application

To test the application, you'll need:

1. A sample image (PNG or JPEG format)
2. Flutter SDK installed on your system

### Steps:

1. **Launch the application:**
   ```bash
   cd /home/runner/work/cropper/cropper
   flutter run -d linux   # or macos/windows
   ```

2. **Test drag and drop:**
   - Drag an image file from your file manager
   - Drop it onto the application window
   - The image should appear in the display area

3. **Test selection box:**
   - Click and drag on the image to create a selection box
   - The selection should be highlighted with a blue border
   - Non-selected areas should have a semi-transparent dark overlay

4. **Test aspect ratio:**
   - Enter `1.0` in the "Aspect Ratio" field for a square selection
   - Enter `1.77` for a 16:9 widescreen aspect ratio
   - Enter `0.5625` for a 9:16 portrait aspect ratio
   - Draw a new selection box and verify it maintains the specified ratio

5. **Test export:**
   - Draw a selection box on the image
   - Click the "Export" button or press Enter
   - Check that the cropped image is saved (default location is next to the original image with a timestamp)
   - Verify the success message appears

6. **Test custom export path:**
   - Enter a custom path in the "Export Path" field (e.g., `/tmp/my_crop.png`)
   - Draw a selection box
   - Export and verify the file is saved to the specified location

7. **Test multiple exports:**
   - After exporting, draw a new selection box
   - Export again with a different selection
   - Verify multiple exports work correctly

## Sample Test Images

You can use any PNG or JPEG image for testing. For best results:
- Use images larger than 500x500 pixels
- Use images with clear visual features to verify cropping accuracy
- Test both landscape and portrait orientations

## Expected Behavior

✓ Drag and drop should accept PNG and JPEG files
✓ Drag and drop should reject other file types with an error message
✓ Selection box should be drawn from the drag start to end point
✓ Aspect ratio constraint should be applied during selection (if specified)
✓ Export should save the selected portion to disk
✓ Enter key should trigger export
✓ After export, selection should be cleared for new selection
✓ Visual feedback should show selected vs non-selected areas
