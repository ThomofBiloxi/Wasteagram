import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:intl/intl.dart';

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
    image = File(pickedFile!.path);

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
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
                              style: TextStyle(fontSize: 20.0)),
                          trailing: Text(post['quantity'].toString(),
                              style: TextStyle(fontSize: 20.0)));
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text('Select photo and upload data'),
                  onPressed: () {
                    uploadData();
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 100.0),
                  ElevatedButton(
                    child: const Text('Select photo and upload data'),
                    onPressed: () {
                      uploadData();
                    },
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
        body: Center(child: CircularProgressIndicator()),
      ),
    );

    final url = await getImage();

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewPostScreen(imageUrl: url),
      ),
    );
  }
}
