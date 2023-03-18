import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_view_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: ListViewScreen(),
    );
  }
}
