import 'package:flutter_test/flutter_test.dart';
import 'package:cropper/main.dart';

void main() {
  testWidgets('Cropper app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CropperApp());

    // Verify that the app title is displayed
    expect(find.text('Image Cropper'), findsOneWidget);

    // Verify that the drop zone text is displayed
    expect(find.text('Drop an image here'), findsOneWidget);

    // Verify that the export button exists
    expect(find.text('Export'), findsOneWidget);
  });

  testWidgets('Control panel elements exist', (WidgetTester tester) async {
    await tester.pumpWidget(const CropperApp());

    // Verify aspect ratio field exists
    expect(find.text('Aspect Ratio (width/height)'), findsOneWidget);

    // Verify export path field exists
    expect(find.text('Export Path (optional)'), findsOneWidget);

    // Verify export button exists
    expect(find.widgetWithText(ElevatedButton, 'Export'), findsOneWidget);
  });
}
