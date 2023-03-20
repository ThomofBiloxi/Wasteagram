import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/model/new_post.dart';
import 'package:location/location.dart';

class NewPostForm extends StatefulWidget {
  final String imageUrl;

  const NewPostForm({super.key, required this.imageUrl});

  @override
  NewPostFormState createState() => NewPostFormState();
}

class NewPostFormState extends State<NewPostForm> {
  final formKey = GlobalKey<FormState>();
  int? quantity;

  /// BEGIN CITED CODE
  /// The Following Code is not my own.
  /// Source: https://canvas.oregonstate.edu/courses/1901286/pages/exploration-platform-hardware-services?module_item_id=22871176
  /// This code checks the location services status and permissions, it then
  ///  uses the location package to retrieve location data into locationData ///
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  /// END CITED CODE ///

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                )),
          ),
          const SizedBox(height: 100),
          Semantics(
              button: true,
              enabled: true,
              onTapHint: 'Submit Form',
              child: FloatingActionButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    final post = Post(
                      date: DateTime.now(),
                      imageURL: widget.imageUrl,
                      quantity: quantity!,
                      latitude: locationData?.latitude ?? 0.0,
                      longitude: locationData?.longitude ?? 0.0,
                    );

                    await FirebaseFirestore.instance
                        .collection('posts')
                        .add(post.toMap());
                    Navigator.pop(context);
                  }
                },
                backgroundColor: Colors.purple,
                child: const Icon(Icons.upload),
              )),
        ],
      ),
    );
  }
}
