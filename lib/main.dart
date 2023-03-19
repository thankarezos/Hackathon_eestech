import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_ok/widget_tree.dart';
import 'firebase_options.dart';
import 'geo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<Position> position = determinePosition();
  Position result = await position;
  print('Latitude: ${result.latitude}, Longitude: ${result.longitude}');
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // try {
  //   String? token = await messaging.getToken();
  //   print('Device token: $token');
  //   messaging.subscribeToTopic('test_topic').then((value) => print('Subscribed to topic'));
  // } catch (error) {
  //   print("Error occurred while sending data: $error");
  // }
  String? token = await messaging.getToken(
    vapidKey: "BEPH7ksgap9jdptnEEWF3FzxhGoecsCy_p74SEEONZvXO7pT8U4JFbLO_wFp4qhDM30IKtyjxeXZ9Js0Ort-uWQ"
  );
  print(token);
  
  try {
    messaging.subscribeToTopic('msgs');
  } catch (error) {
    print("Error occurred while sending data: $error");
  }
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  print('User granted permission: ${settings.authorizationStatus}');
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
