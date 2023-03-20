import 'package:flutter/material.dart';
import 'package:wasteagram/screens/camera_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(title: const Text('Wasteagram'), centerTitle: true),
          body: const CameraScreen()),
    );
  }
}
