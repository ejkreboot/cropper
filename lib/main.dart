import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:image/image.dart' as img;
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const CropperApp());
}

class CropperApp extends StatelessWidget {
  const CropperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Cropper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CropperHomePage(),
    );
  }
}

class CropperHomePage extends StatefulWidget {
  const CropperHomePage({super.key});

  @override
  State<CropperHomePage> createState() => _CropperHomePageState();
}

class _CropperHomePageState extends State<CropperHomePage> {
  Uint8List? _imageData;
  String? _imagePath;
  Rect? _selectionRect;
  Offset? _dragStart;
  bool _isDragging = false;
  final TextEditingController _aspectRatioController = TextEditingController(text: '1.0');
  final TextEditingController _exportPathController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double? _aspectRatio;

  @override
  void initState() {
    super.initState();
    _aspectRatioController.addListener(_updateAspectRatio);
    _updateAspectRatio();
  }

  @override
  void dispose() {
    _aspectRatioController.dispose();
    _exportPathController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateAspectRatio() {
    final value = double.tryParse(_aspectRatioController.text);
    setState(() {
      _aspectRatio = (value != null && value > 0) ? value : null;
    });
  }

  Future<void> _handleDrop(List<String> paths) async {
    if (paths.isEmpty) return;
    
    final path = paths.first;
    if (!path.toLowerCase().endsWith('.png') && 
        !path.toLowerCase().endsWith('.jpg') && 
        !path.toLowerCase().endsWith('.jpeg')) {
      _showError('Please drop an image file (PNG or JPEG)');
      return;
    }

    try {
      final file = File(path);
      final bytes = await file.readAsBytes();
      setState(() {
        _imageData = bytes;
        _imagePath = path;
        _selectionRect = null;
      });
      _focusNode.requestFocus();
    } catch (e) {
      _showError('Failed to load image: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Offset _constrainPoint(Offset point, Size imageSize) {
    return Offset(
      point.dx.clamp(0.0, imageSize.width),
      point.dy.clamp(0.0, imageSize.height),
    );
  }

  void _onPanStart(DragStartDetails details, Size imageSize) {
    setState(() {
      _dragStart = _constrainPoint(details.localPosition, imageSize);
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details, Size imageSize) {
    if (_dragStart == null) return;

    final currentPoint = _constrainPoint(details.localPosition, imageSize);
    final topLeft = Offset(
      _dragStart!.dx < currentPoint.dx ? _dragStart!.dx : currentPoint.dx,
      _dragStart!.dy < currentPoint.dy ? _dragStart!.dy : currentPoint.dy,
    );
    final bottomRight = Offset(
      _dragStart!.dx > currentPoint.dx ? _dragStart!.dx : currentPoint.dx,
      _dragStart!.dy > currentPoint.dy ? _dragStart!.dy : currentPoint.dy,
    );

    var width = bottomRight.dx - topLeft.dx;
    var height = bottomRight.dy - topLeft.dy;

    // Apply aspect ratio constraint if specified
    if (_aspectRatio != null && width > 0 && height > 0) {
      final currentRatio = width / height;
      if (currentRatio > _aspectRatio!) {
        // Width is too large, constrain it
        width = height * _aspectRatio!;
      } else {
        // Height is too large, constrain it
        height = width / _aspectRatio!;
      }

      // Ensure the constrained box doesn't exceed image bounds
      if (topLeft.dx + width > imageSize.width) {
        width = imageSize.width - topLeft.dx;
        height = width / _aspectRatio!;
      }
      if (topLeft.dy + height > imageSize.height) {
        height = imageSize.height - topLeft.dy;
        width = height * _aspectRatio!;
      }
    }

    setState(() {
      _selectionRect = Rect.fromLTWH(topLeft.dx, topLeft.dy, width, height);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }

  Future<void> _exportSelection() async {
    if (_imageData == null || _selectionRect == null) {
      _showError('Please select an area to export');
      return;
    }

    if (_selectionRect!.width < 1 || _selectionRect!.height < 1) {
      _showError('Selection area is too small');
      return;
    }

    try {
      // Decode the image
      final originalImage = img.decodeImage(_imageData!);
      if (originalImage == null) {
        _showError('Failed to decode image');
        return;
      }

      // Get the display size to calculate scale factor
      final displaySize = _getDisplaySize();
      final scaleX = originalImage.width / displaySize.width;
      final scaleY = originalImage.height / displaySize.height;

      // Scale the selection rectangle to original image coordinates
      final scaledRect = Rect.fromLTWH(
        _selectionRect!.left * scaleX,
        _selectionRect!.top * scaleY,
        _selectionRect!.width * scaleX,
        _selectionRect!.height * scaleY,
      );

      // Crop the image
      final croppedImage = img.copyCrop(
        originalImage,
        x: scaledRect.left.round(),
        y: scaledRect.top.round(),
        width: scaledRect.width.round(),
        height: scaledRect.height.round(),
      );

      // Determine export path
      String exportPath;
      if (_exportPathController.text.isNotEmpty) {
        exportPath = _exportPathController.text;
      } else {
        // Generate default path based on original image
        final originalFile = File(_imagePath!);
        final dir = originalFile.parent.path;
        final name = originalFile.uri.pathSegments.last;
        final nameWithoutExt = name.substring(0, name.lastIndexOf('.'));
        final ext = name.substring(name.lastIndexOf('.'));
        exportPath = '$dir/${nameWithoutExt}_cropped_${DateTime.now().millisecondsSinceEpoch}$ext';
      }

      // Encode and save
      final encodedImage = exportPath.toLowerCase().endsWith('.png')
          ? img.encodePng(croppedImage)
          : img.encodeJpg(croppedImage);
      
      await File(exportPath).writeAsBytes(encodedImage);
      
      _showSuccess('Image exported to: $exportPath');
      
      // Reset selection to allow new export
      setState(() {
        _selectionRect = null;
      });
    } catch (e) {
      _showError('Failed to export image: $e');
    }
  }

  Size? _cachedDisplaySize;

  void _cacheDisplaySize(Size size) {
    _cachedDisplaySize = size;
  }

  Size _getDisplaySize() {
    return _cachedDisplaySize ?? const Size(800, 600);
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
      _exportSelection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Image Cropper'),
        ),
        body: Column(
          children: [
            // Control panel
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _aspectRatioController,
                      decoration: const InputDecoration(
                        labelText: 'Aspect Ratio (width/height)',
                        hintText: 'e.g., 1.0 for square, 1.77 for 16:9',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _exportPathController,
                      decoration: const InputDecoration(
                        labelText: 'Export Path (optional)',
                        hintText: 'Leave empty for auto-generated path',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _exportSelection,
                    icon: const Icon(Icons.download),
                    label: const Text('Export'),
                  ),
                ],
              ),
            ),
            // Image display area
            Expanded(
              child: DropTarget(
                onDragDone: (detail) => _handleDrop(detail.files.map((f) => f.path).toList()),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.grey[200],
                  ),
                  child: _imageData == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'Drop an image here',
                                style: TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ImageCropWidget(
                          imageData: _imageData!,
                          selectionRect: _selectionRect,
                          onPanStart: _onPanStart,
                          onPanUpdate: _onPanUpdate,
                          onPanEnd: _onPanEnd,
                          onDisplaySizeCalculated: _cacheDisplaySize,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCropWidget extends StatelessWidget {
  final Uint8List imageData;
  final Rect? selectionRect;
  final Function(DragStartDetails, Size) onPanStart;
  final Function(DragUpdateDetails, Size) onPanUpdate;
  final Function(DragEndDetails) onPanEnd;
  final Function(Size)? onDisplaySizeCalculated;

  const ImageCropWidget({
    super.key,
    required this.imageData,
    required this.selectionRect,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    this.onDisplaySizeCalculated,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<ImageInfo>(
          future: _getImageInfo(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final imageInfo = snapshot.data!;
            final imageWidth = imageInfo.image.width.toDouble();
            final imageHeight = imageInfo.image.height.toDouble();

            // Calculate display size maintaining aspect ratio
            final containerWidth = constraints.maxWidth;
            final containerHeight = constraints.maxHeight;
            final imageAspectRatio = imageWidth / imageHeight;
            final containerAspectRatio = containerWidth / containerHeight;

            double displayWidth;
            double displayHeight;

            if (containerAspectRatio > imageAspectRatio) {
              displayHeight = containerHeight;
              displayWidth = displayHeight * imageAspectRatio;
            } else {
              displayWidth = containerWidth;
              displayHeight = displayWidth / imageAspectRatio;
            }

            final displaySize = Size(displayWidth, displayHeight);
            
            // Cache the display size for export calculations
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onDisplaySizeCalculated?.call(displaySize);
            });

            return Center(
              child: GestureDetector(
                onPanStart: (details) => onPanStart(details, displaySize),
                onPanUpdate: (details) => onPanUpdate(details, displaySize),
                onPanEnd: onPanEnd,
                child: SizedBox(
                  width: displayWidth,
                  height: displayHeight,
                  child: Stack(
                    children: [
                      Image.memory(
                        imageData,
                        width: displayWidth,
                        height: displayHeight,
                        fit: BoxFit.contain,
                      ),
                      CustomPaint(
                        size: Size(displayWidth, displayHeight),
                        painter: SelectionOverlayPainter(
                          selectionRect: selectionRect,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<ImageInfo> _getImageInfo() async {
    final completer = Completer<ImageInfo>();
    final image = MemoryImage(imageData);
    final stream = image.resolve(const ImageConfiguration());
    stream.addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    return completer.future;
  }
}

class SelectionOverlayPainter extends CustomPainter {
  final Rect? selectionRect;

  SelectionOverlayPainter({
    required this.selectionRect,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (selectionRect == null) return;
    
    // Draw semi-transparent overlay on non-selected areas
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.5);
    
    // Top area
    if (selectionRect!.top > 0) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, selectionRect!.top),
        overlayPaint,
      );
    }
    
    // Bottom area
    if (selectionRect!.bottom < size.height) {
      canvas.drawRect(
        Rect.fromLTWH(0, selectionRect!.bottom, size.width, size.height - selectionRect!.bottom),
        overlayPaint,
      );
    }
    
    // Left area
    if (selectionRect!.left > 0) {
      canvas.drawRect(
        Rect.fromLTWH(0, selectionRect!.top, selectionRect!.left, selectionRect!.height),
        overlayPaint,
      );
    }
    
    // Right area
    if (selectionRect!.right < size.width) {
      canvas.drawRect(
        Rect.fromLTWH(selectionRect!.right, selectionRect!.top, size.width - selectionRect!.right, selectionRect!.height),
        overlayPaint,
      );
    }
    
    // Draw selection border
    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawRect(selectionRect!, borderPaint);
    
    // Draw corner handles
    final handlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    
    final handleSize = 8.0;
    canvas.drawCircle(selectionRect!.topLeft, handleSize, handlePaint);
    canvas.drawCircle(selectionRect!.topRight, handleSize, handlePaint);
    canvas.drawCircle(selectionRect!.bottomLeft, handleSize, handlePaint);
    canvas.drawCircle(selectionRect!.bottomRight, handleSize, handlePaint);
  }

  @override
  bool shouldRepaint(SelectionOverlayPainter oldDelegate) {
    return oldDelegate.selectionRect != selectionRect;
  }
}
