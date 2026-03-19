import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

// CAI NAY DETECT LOCAL NÊN DEV MỚI CÓ THỂ DÙNG ĐƯỢC NHÉ - AP
class DetectService {
  late Interpreter interpreter;
  List<String> labels = [];

  Future init() async {
    interpreter = await Interpreter.fromAsset('assets/detect.tflite');
    final labelTxt = await rootBundle.loadString('assets/labelmap.txt');
    labels = labelTxt.split('\n').where((e) => e.isNotEmpty).toList();
    print("AI READY");
  }

  Future<Map<String, dynamic>> detect(File file) async {
    final bytes = await file.readAsBytes();
    img.Image? ori = img.decodeImage(bytes);
    if (ori == null) return {};

    img.Image resized = img.copyResize(ori, width: 300, height: 300);

    var input = List.generate(
      1,
      (_) => List.generate(
        300,
        (y) => List.generate(300, (x) {
          final p = resized.getPixel(x, y);
          return [p.r, p.g, p.b];
        }),
      ),
    );

    var boxes = List.filled(40, 0.0).reshape([1, 10, 4]);
    var classes = List.filled(10, 0.0).reshape([1, 10]);
    var scores = List.filled(10, 0.0).reshape([1, 10]);
    var num = List.filled(1, 0.0);

    interpreter.runForMultipleInputs(
      [input],
      {0: boxes, 1: classes, 2: scores, 3: num},
    );

    return {
      "boxes": boxes[0],
      "classes": classes[0],
      "scores": scores[0],
      "labels": labels,
    };
  }
}
