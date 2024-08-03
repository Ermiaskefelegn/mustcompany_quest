// data/datasources/screenshot_service.dart
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// class ScreenshotService {
//   Future<void> captureScreenshot(GlobalKey key) async {
//     await Future.delayed(const Duration(
//         milliseconds: 100)); // Ensures the widget is fully rendered

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       RenderRepaintBoundary boundary =
//           key.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       var image = await boundary.toImage();
//       ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
//       Uint8List pngBytes = byteData!.buffer.asUint8List();

//       final directory = (await getApplicationDocumentsDirectory()).path;
//       File imgFile = File('$directory/screenshot.png');
//       imgFile.writeAsBytes(pngBytes);
//       print(imgFile.path);
//     });
//   }
// }

class ScreenshotService {
  Future<void> captureScreenshot(
      GlobalKey key, Function(String) onScreenshotTaken) async {
    await Future.delayed(const Duration(
        milliseconds: 100)); // Ensures the widget is fully rendered

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = File('$directory/screenshot.png');
      await imgFile.writeAsBytes(pngBytes);
      onScreenshotTaken(imgFile.path);
    });
  }
}
