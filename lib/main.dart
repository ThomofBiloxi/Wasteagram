import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://d442b63c115a48db9f30eb44c901c400@o4504868840865792.ingest.sentry.io/4504868842962944';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
  );
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}