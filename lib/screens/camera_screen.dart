// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/detail_screen.dart';

import '../widgets/upload_button.dart';

///BEGIN CITED CODE
/// The following code is not completely my own
/// SOURCE: https://canvas.oregonstate.edu/courses/1901286/pages/exploration-firebase-cloud-firestore-and-storage?module_item_id=22871178
/// The code picks an image from the gallery, uploads it to Firebase Storage
/// and returns the URL of the image in Firebase Storage.
/// The StreamBuilder calls the instance of Firebase storage and pulls snapshots of the data store there.
/// It then creates a ListView of the snapshots of that data in the format I set up///
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  File? image;
  final picker = ImagePicker();

/*
* Pick an image from the gallery, upload it to Firebase Storage and return 
* the URL of the image in Firebase Storage.
*/
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    }
    image = File(pickedFile.path);
    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    var url = await storageReference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      var timestamp = Timestamp.fromMillisecondsSinceEpoch(
                          post['date'].millisecondsSinceEpoch);
                      var date = timestamp.toDate();
                      var formattedDate =
                          DateFormat('EEEE, MMMM d, yyyy').format(date);
                      return ListTile(
                        leading: Text(formattedDate,
                            style: const TextStyle(fontSize: 20.0)),
                        trailing: Text(post['quantity'].toString(),
                            style: const TextStyle(fontSize: 20.0)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(post: post)));
                        },
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
                    child: UploadButton(onPressed: () {
                      uploadData();
                    }),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Semantics(
                          button: true,
                          enabled: true,
                          onTapHint: 'Slect an image',
                          child: UploadButton(onPressed: () {
                            uploadData();
                          })),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  void uploadData() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('New Post'),
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );

    final url = await getImage();
    Navigator.pop(context);

    if (url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPostScreen(imageUrl: url),
        ),
      );
    }
  }

  ///END CITED CODE///
}
