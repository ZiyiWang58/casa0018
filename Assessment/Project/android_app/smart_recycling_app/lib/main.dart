import 'package:flutter/material.dart';
import 'models/classification_result.dart';
import 'services/classifier_service.dart';

void main() {
  runApp(const SmartRecyclingApp());
}

class SmartRecyclingApp extends StatelessWidget {
  const SmartRecyclingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Recycling Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const StaticInferenceScreen(),
    );
  }
}

class StaticInferenceScreen extends StatefulWidget {
  const StaticInferenceScreen({super.key});

  @override
  State<StaticInferenceScreen> createState() => _StaticInferenceScreenState();
}

class _StaticInferenceScreenState extends State<StaticInferenceScreen> {
  final ClassifierService _classifierService = ClassifierService();

  bool _loading = true;
  bool _running = false;
  String _status = 'Loading model...';
  ClassificationResult? _result;

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  Future<void> _initModel() async {
    try {
      await _classifierService.loadModel();
      setState(() {
        _loading = false;
        _status = 'Model loaded';
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _status = 'Failed to load model: $e';
      });
    }
  }

  Future<void> _runTestInference() async {
    setState(() {
      _running = true;
      _status = 'Running inference...';
    });

    try {
      final result = await _classifierService.classifyAssetImage(
        'assets/test_images/can_049.JPG',
      );

      setState(() {
        _result = result;
        _running = false;
        _status = 'Inference complete';
      });
    } catch (e) {
      setState(() {
        _running = false;
        _status = 'Inference failed: $e';
      });
    }
  }

  @override
  void dispose() {
    _classifierService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final confidenceText = _result == null
        ? '-'
        : '${(_result!.confidence * 100).toStringAsFixed(1)}%';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Recycling Assistant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Static Inference Test',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This screen tests whether the Edge Impulse model can run locally inside the Flutter app.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(_status),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  const Text('Prediction', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    _result?.label ?? '-',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text('Confidence', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    confidenceText,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_loading || _running) ? null : _runTestInference,
                child: Text(_running ? 'Running...' : 'Run test inference'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}