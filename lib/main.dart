import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:ohlify/app.dart';
import 'package:ohlify/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Text(
          'Something went wrong.',
          style: TextStyle(color: Colors.red[700]),
        ),
      ),
    );
  };

  runApp(const AppProviders(child: App()));
}
