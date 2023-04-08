import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/screens/post_feed_screen.dart';

class MyApp extends StatelessWidget {
  // Initialize Firebase Analytics and Analytics Observer
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      navigatorObservers: <NavigatorObserver>[observer],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wasteagram'),
          centerTitle: true,
        ),
        body: const PostFeedScreen(),
      ),
    );
  }
}
