import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UploadButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.purple,
      child: const Icon(Icons.camera),
    );
  }
}
