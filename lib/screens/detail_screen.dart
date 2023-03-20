import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatelessWidget {
  final DocumentSnapshot post;

  const DetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  DateFormat('EEEE, MMMM d, yyyy')
                      .format(post['date'].toDate()),
                  style: const TextStyle(fontSize: 32.0)),
              const Spacer(flex: 3),
              Semantics(
                  image: true,
                  label: 'Food that has been wasted',
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage, image: post['imageURL'])),
              const Spacer(flex: 3),
              Semantics(
                  label: 'number of waste items in the photo',
                  onTapHint: 'number of waste items',
                  child: Text('${post['quantity']} items',
                      style: const TextStyle(fontSize: 32.0))),
              const Spacer(flex: 3),
              Semantics(
                  label: 'Location in (latitude, longitude)',
                  onTapHint: 'location data',
                  child: Text(
                      'Location: (${post['latitude']}, ${post['longitude']})')),
            ],
          ),
        ),
      ),
    );
  }
}
