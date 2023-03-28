import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatelessWidget {
  final DocumentSnapshot post;

  const DetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final formattedDate = dateFormat.format(post['date'].toDate());

    final imageBoxSize = isTablet ? screenSize.width * 0.7 : null;
    final imageSize = isTablet ? Size(imageBoxSize!, imageBoxSize) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Post Details'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: TextStyle(fontSize: isTablet ? 48.0 : 32.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isTablet ? 32.0 : 16.0),
              Semantics(
                image: true,
                label: 'Food that has been wasted',
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: post['imageURL'],
                  width: imageSize?.width,
                  height: imageSize?.height,
                ),
              ),
              SizedBox(height: isTablet ? 64.0 : 32.0),
              Semantics(
                label: 'number of waste items in the photo',
                onTapHint: 'number of waste items',
                child: Text(
                  '${post['quantity']} items',
                  style: TextStyle(fontSize: isTablet ? 48.0 : 32.0),
                ),
              ),
              SizedBox(height: isTablet ? 64.0 : 32.0),
              Semantics(
                label: 'Location in (latitude, longitude)',
                onTapHint: 'location data',
                child: Text(
                  'Location: (${post['latitude']}, ${post['longitude']})',
                  style: TextStyle(fontSize: isTablet ? 32.0 : 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
