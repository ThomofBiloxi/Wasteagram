import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import '../widgets/loading_posts.dart';
import '../widgets/upload_button.dart';

class PostFeedScreen extends StatefulWidget {

  const PostFeedScreen({Key? key}) : super(key: key);

  @override
  _PostFeedScreenState createState() =>
      _PostFeedScreenState(); 
}

class _PostFeedScreenState extends State<PostFeedScreen> {
  
  File? _image; 
  final _picker = ImagePicker(); 

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // if there is data in Firebase
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data!.docs[index];
                    final timestamp = Timestamp.fromMillisecondsSinceEpoch(
                      post['date'].millisecondsSinceEpoch,
                    );
                    final date = timestamp.toDate();
                    final formattedDate =
                        DateFormat('EEEE, MMMM d, yyyy').format(date);
                    return ListTile(
                      leading: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      trailing: Text(
                        post['quantity'].toString(),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(post: post),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                child: Semantics(
                  button: true,
                  enabled: true,
                  onTapHint: 'Select an image',
                  child: UploadButton(
                    onPressed: () =>
                        _handleUploadButtonPressed(),
                  ),
                ),
              ),
            ],
          );
        } else {
          //if there is no data in Firebase
          return LoadingPosts(
              onPressed:
                  _handleUploadButtonPressed);
        }
      },
    );
  }

  //Return the image url from Firebase Storage
  Future<String?> _getImageUrl() async {
    
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    _image = File(pickedFile.path);
    final fileName =
        '${DateTime.now()}.jpg';
    final storageReference = FirebaseStorage.instance
        .ref()
        .child(fileName); 
    final uploadTask = storageReference
        .putFile(_image!); 
    await uploadTask;
    final url = await storageReference
        .getDownloadURL(); 
    return url;
  }

  void _handleUploadButtonPressed() async {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('New Post'),
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    try {
      final url = await _getImageUrl(); 
      Navigator.pop(context);

      if (url != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPostScreen(imageUrl: url),
          ),
        );
      }
    } catch (error, stackTrace) {
      //if an error occurs while uploading the image
      await Sentry.captureException(error,
          stackTrace:
              stackTrace); 

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while uploading the image.'),
        ),
      );
    }
  }
}
