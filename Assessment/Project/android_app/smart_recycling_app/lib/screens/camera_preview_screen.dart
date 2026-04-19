import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _cameraReady = false;
  String _status = 'Initializing camera...';

  @override
  void initState() {
    super.initState();
    _setupCamera();
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

  @override
  void dispose() {
    _controller?.dispose();
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
            return CameraPreview(_controller!);
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Recycling Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              width: double.infinity,
              child: previewContent,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border(top: BorderSide(color: Colors.green.shade200)),
            ),
            child: Column(
              children: [
                const Text(
                  'Camera Preview Test',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _status,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'This stage verifies that the Android phone camera can be used inside the custom Flutter app before adding real-time classification.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}