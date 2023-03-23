import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_ok/widget_tree.dart';
import 'firebase_options.dart';
import 'geo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> sendData() async {
  try {
    Future<Position> position = determinePosition();
    Position result = await position;
    print('Latitude: ${result.latitude}, Longitude: ${result.longitude}');
    final databaseReference = FirebaseDatabase.instance.ref();
    final locationRef = databaseReference.child('locations').push();
    await locationRef
        .set({'latitude': result.latitude, 'longitude': result.longitude});

    print("finished");
  } catch (error) {
    print("Error occurred while sending data: $error");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Future<Position> position = determinePosition();
  Position result = await position;
  print('Latitude: ${result.latitude}, Longitude: ${result.longitude}');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // sendData();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // try {
  //   String? token = await messaging.getToken();
  //   print('Device token: $token');
  //   messaging.subscribeToTopic('test_topic').then((value) => print('Subscribed to topic'));
  // } catch (error) {
  //   print("Error occurred while sending data: $error");
  // }
  String? token = await messaging.getToken(
      vapidKey:
          "BEPH7ksgap9jdptnEEWF3FzxhGoecsCy_p74SEEONZvXO7pT8U4JFbLO_wFp4qhDM30IKtyjxeXZ9Js0Ort-uWQ");
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
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      print('Title: ${message.notification!.title}');
      print('Body: ${message.notification!.body}');
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'your_channel_id', // id
        'your_channel_name', // title
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0, // notification id
        message.notification!.title, // notification title
        message.notification!.body, // notification body
        platformChannelSpecifics,
      );
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
