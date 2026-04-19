import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_litert/flutter_litert.dart';
import 'package:image/image.dart' as img;
import '../models/classification_result.dart';

class ClassifierService {
  Interpreter? _interpreter;
  List<String> _labels = [];

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/models/waste_classifier.tflite');

    final labelsRaw = await rootBundle.loadString('assets/labels/waste_labels.txt');
    _labels = labelsRaw
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  Future<ClassificationResult> classifyAssetImage(String assetPath) async {
    if (_interpreter == null) {
      throw Exception('Interpreter not loaded. Call loadModel() first.');
    }

    final byteData = await rootBundle.load(assetPath);
    final imageBytes = byteData.buffer.asUint8List();
    final decoded = img.decodeImage(imageBytes);

    if (decoded == null) {
      throw Exception('Failed to decode image.');
    }

    final resized = img.copyResize(decoded, width: 96, height: 96);

    final input = _imageToInput(resized);
    final output = _createOutputBuffer();

    _interpreter!.run(input, output);

    final scores = _extractScores(output);
    int bestIndex = 0;
    double bestScore = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > bestScore) {
        bestScore = scores[i];
        bestIndex = i;
      }
    }

    final label = bestIndex < _labels.length ? _labels[bestIndex] : 'unknown';

    return ClassificationResult(
      label: label,
      confidence: bestScore,
    );
  }

  List<List<List<List<double>>>> _imageToInput(img.Image image) {
    return [
      List.generate(96, (y) {
        return List.generate(96, (x) {
          final pixel = image.getPixel(x, y);
          final r = pixel.r / 255.0;
          final g = pixel.g / 255.0;
          final b = pixel.b / 255.0;
          return [r, g, b];
        });
      })
    ];
  }

  List<List<double>> _createOutputBuffer() {
    return [List.filled(_labels.length, 0.0)];
  }

  List<double> _extractScores(List<List<double>> output) {
    return output.first;
  }

  void close() {
    _interpreter?.close();
  }
}