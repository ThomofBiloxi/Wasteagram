import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  @override
  ListViewScreenState createState() => ListViewScreenState();
}

class ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Wasteagram')),
    );
  }
}
