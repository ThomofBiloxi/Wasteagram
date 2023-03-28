import 'package:flutter/material.dart';
import '../widgets/upload_button.dart';

class LoadingPosts extends StatelessWidget {
  final VoidCallback onPressed;

  const LoadingPosts({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Show a loading indicator in the center of the screen.
          const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),

          // Show an "upload" button at the bottom of the screen.
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Semantics(
                button: true,
                enabled: true,
                onTapHint: 'Select an image',
                child: UploadButton(
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
