import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/model/new_post.dart';

class NewPostForm extends StatefulWidget {
  final String imageUrl;

  NewPostForm({required this.imageUrl});

  @override
  NewPostFormState createState() => NewPostFormState();
}

class NewPostFormState extends State<NewPostForm> {
  final formKey = GlobalKey<FormState>();
  int? quantity;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Number of items'),
            validator: (value) {
              if (value == null || value.isEmpty || value == 0) {
                return 'Please enter the number of items';
              }
              int? intValue = int.tryParse(value);
              if (intValue == null || intValue <= 0) {
                return 'Please enter the number of items';
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                quantity = int.tryParse(value!);
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                final post = Post(
                  date: DateTime.now(),
                  imageURL: widget.imageUrl,
                  quantity: quantity!,
                  latitude: 0.0,
                  longitude: 0.0,
                );

                await FirebaseFirestore.instance
                    .collection('posts')
                    .add(post.toMap());

                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
