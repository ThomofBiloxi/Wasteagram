import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../widgets/new_post_form.dart';

class NewPostScreen extends StatefulWidget {
  final String imageUrl;

  const NewPostScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('New Post'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Semantics(
                image: true,
                label: 'selected image showing food waste',
                onTapHint: 'food waste photo',
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.imageUrl,
                ),
              ),
            ),
          ),
          NewPostForm(imageUrl: widget.imageUrl),
        ],
      ),
    );
  }
}
