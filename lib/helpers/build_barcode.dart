import 'dart:io';
import 'package:barcode/barcode.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _appDocumentsPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

/// Gets barcode file path
Future<File> get barcodeFile async {
  final path = await _appDocumentsPath;
  return File('$path/barcode.svg');
}

/// Buids barcode in svg
Future<String> buildBarcode(
  String data, {
  Barcode bc,
  String filename = 'barcode',
  double width = 200,
  double height = 200,
  // double fontHeight = 20,
}) async {
  /// Create the Barcode
  // bc = Barcode.code128(useCode128A: false, useCode128C: false);
  bc ??= Barcode.qrCode();

  final rawSvg = bc.toSvg(data,
      width: width ?? 200,
      height: height ?? 200,
      // fontHeight: fontHeight,
      drawText: true,
      fullSvg: true);

  // Save the image

  final file = await barcodeFile;
  await file.writeAsString(rawSvg);
  print(file.path);
  return file.path;
}

/// Animated barcode
Widget barCodeAnimated(String path, {bool run = false}) {
  if (path.isEmpty) return const SizedBox(height: 20);
  return Container(
    color: Colors.white,
    height: 200,
    child: Expanded(
      child: AnimatedDrawing.svg(
        path,
        run: run,
        duration: const Duration(seconds: 3),
        lineAnimation: LineAnimation.oneByOne,
        animationOrder: PathOrders.decreasingLength,
        animationCurve: Curves.linear,
        onFinish: () => run = false,
      ),
    ),
  );
}

// Future<Picture> getSvgImage() async {
//   final file = await barcodeFile;
//   final picture = SvgPicture.file(file);
//   picture.
//   final svgRoot = await SvgPicture.file(file, color: Colors.blue);
// }
