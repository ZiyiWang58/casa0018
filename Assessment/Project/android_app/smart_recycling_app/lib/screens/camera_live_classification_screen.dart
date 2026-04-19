import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../models/classification_result.dart';
import '../services/classifier_service.dart';

class CameraLiveClassificationScreen extends StatefulWidget {
  const CameraLiveClassificationScreen({super.key});

  @override
  State<CameraLiveClassificationScreen> createState() =>
      _CameraLiveClassificationScreenState();
}

class _CameraLiveClassificationScreenState
    extends State<CameraLiveClassificationScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  final ClassifierService _classifierService = ClassifierService();

  bool _cameraReady = false;
  bool _modelReady = false;
  bool _running = false;
  bool _isProcessingFrame = false;

  Timer? _timer;

  String _status = 'Initializing...';
  ClassificationResult? _result;

  @override
  void initState() {
    super.initState();
    _setupEverything();
  }

  Future<void> _setupEverything() async {
    await _setupCamera();
    await _setupModel();

    if (_cameraReady && _modelReady) {
      _startPeriodicInference();
      setState(() {
        _running = true;
        _status = 'Live classification running';
      });
    }
  }

  Future<void> _setupCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        setState(() {
          _status = 'No camera found on device';
        });
        return;
      }

      final backCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;

      if (!mounted) return;

      setState(() {
        _cameraReady = true;
        _status = 'Camera ready';
      });
    } catch (e) {
      setState(() {
        _status = 'Camera init failed: $e';
      });
    }
  }

  Future<void> _setupModel() async {
    try {
      await _classifierService.loadModel();
      if (!mounted) return;
      setState(() {
        _modelReady = true;
        _status = 'Model ready';
      });
    } catch (e) {
      setState(() {
        _status = 'Model load failed: $e';
      });
    }
  }

  void _startPeriodicInference() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 1500), (_) async {
      if (!_cameraReady || !_modelReady || _controller == null) return;
      if (_isProcessingFrame) return;

      _isProcessingFrame = true;

      try {
        final XFile file = await _controller!.takePicture();
        final Uint8List bytes = await file.readAsBytes();

        final result = await _classifierService.classifyBytes(bytes);

        if (!mounted) return;

        setState(() {
          _result = result;
          _status = 'Live classification running';
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _status = 'Inference failed: $e';
        });
      } finally {
        _isProcessingFrame = false;
      }
    });
  }

  void _toggleRunning() {
    if (_running) {
      _timer?.cancel();
      setState(() {
        _running = false;
        _status = 'Paused';
      });
    } else {
      _startPeriodicInference();
      setState(() {
        _running = true;
        _status = 'Live classification running';
      });
    }
  }

  String _suggestionForLabel(String? label) {
    switch (label) {
      case 'can':
        return 'Recycle as metal can';
      case 'plastic_bottle':
        return 'Recycle as plastic bottle';
      case 'used_tissue':
        return 'Dispose as used tissue waste';
      default:
        return 'No suggestion available';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    _classifierService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent;

    if (_controller == null) {
      previewContent = Center(
        child: Text(_status),
      );
    } else {
      previewContent = FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && _cameraReady) {
            return ClipRect(
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller!.value.previewSize!.height,
                    height: _controller!.value.previewSize!.width,
                    child: CameraPreview(_controller!),
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Camera preview error: ${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    final confidenceText = _result == null
        ? '-'
        : '${(_result!.confidence * 100).toStringAsFixed(1)}%';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Recycling Assistant'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: Colors.black,
                child: previewContent,
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Prediction',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _result?.label ?? '-',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Confidence: $confidenceText',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _suggestionForLabel(_result?.label),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (!_cameraReady || !_modelReady)
                            ? null
                            : _toggleRunning,
                        child: Text(
                          _running ? 'Pause classification' : 'Resume classification',
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _running ? 'Running locally on device' : 'Classification paused',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}