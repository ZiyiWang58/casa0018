import 'package:flutter/material.dart';
import 'screens/camera_preview_screen.dart';

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
      home: const CameraPreviewScreen(),
    );
  }
}