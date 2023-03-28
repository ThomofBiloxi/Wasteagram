import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/model/new_post.dart';
import 'package:location/location.dart';

class NewPostForm extends StatefulWidget {
  final String imageUrl;

  const NewPostForm({Key? key, required this.imageUrl}) : super(key: key);

  @override
  NewPostFormState createState() => NewPostFormState();
}

class NewPostFormState extends State<NewPostForm> {
  final _formKey = GlobalKey<FormState>();
  int? _quantity;

  LocationData? _locationData;
  final _locationService = Location();

  @override
  void initState() {
    super.initState();
    _retrieveLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Semantics(
              textField: true,
              enabled: true,
              onTapHint: 'Enter the number of items',
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Number of items'),

                // Validate that the input is not null, not empty, and not zero.
                validator: (value) {
                  if (value == null || value.isEmpty || value == '0') {
                    return 'Please enter the number of items';
                  }
                  final intValue = int.tryParse(value);
                  if (intValue == null || intValue <= 0) {
                    return 'Please enter a positive number of items';
                  }
                  return null;
                },

                // Save the quantity as an integer.
                onSaved: (value) {
                  setState(() {
                    _quantity = int.tryParse(value!);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 25),
          Semantics(
            button: true,
            enabled: true,
            onTapHint: 'Submit Form',
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Create a new post object.
                    final post = Post(
                      date: DateTime.now(),
                      imageURL: widget.imageUrl,
                      quantity: _quantity!,

                      // Use the latitude and longitude of the device's location.
                      latitude: _locationData?.latitude ?? 0.0,
                      longitude: _locationData?.longitude ?? 0.0,
                    );

                    // Add the new post to Firestore.
                    await FirebaseFirestore.instance
                        .collection('posts')
                        .add(post.toMap());

                    // Navigate back to the previous screen.
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print('Error writing to Firestore: $e');

                  // Show a snackbar indicating that there was an error.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'An error occurred while posting. Please try again later.'),
                    ),
                  );
                }
              },
              backgroundColor: Colors.purple,
              child: const Icon(Icons.upload),
            ),
          ),
        ],
      ),
    );
  }

  // Retrieve the device's location and store it in _locationData.
  void _retrieveLocation() async {
    try {
      var serviceEnabled = await _locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _locationService.requestService();
        if (!serviceEnabled) {
          print('Failed to enable location service. Returning.');
          return;
        }
      }

      var permissionGranted = await _locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      _locationData = await _locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');

      // Set _locationData to null if an error occurs.
      _locationData = null;
    }

// Update the state to reflect any changes to _locationData.
    setState(() {
    });
  }
}
