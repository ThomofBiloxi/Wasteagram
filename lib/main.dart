import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  // Ensure that widget binding is initialized before using it.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Sentry for error tracking.
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://d442b63c115a48db9f30eb44c901c400@o4504868840865792.ingest.sentry.io/4504868842962944';
      options.tracesSampleRate = 1.0;
    },
  );

  // Set preferred device orientation to portrait mode only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase.
  await Firebase.initializeApp();

  // Run the app.
  runApp(const MyApp());
}
