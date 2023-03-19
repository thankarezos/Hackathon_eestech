import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_ok/widget_tree.dart';
import 'firebase_options.dart';
import 'geo.dart';
import 'package:geolocator/geolocator.dart';


Future<void> main() async {
  Future<Position> position = determinePosition();
  Position result = await position;
  print('Latitude: ${result.latitude}, Longitude: ${result.longitude}');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WidgetTree(),
    );
  }
}
