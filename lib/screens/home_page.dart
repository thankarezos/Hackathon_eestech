import 'package:hello_ok/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../geo.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUSer;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign out'));
  }

  Widget _senddata() {
    return ElevatedButton(onPressed: sendData, child: const Text('Send Data'));

  }

Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => sendData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


Future<void> sendData() async {
  try {
    Future<Position> position = determinePosition();
    Position result = await position;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken(
      vapidKey: "BEPH7ksgap9jdptnEEWF3FzxhGoecsCy_p74SEEONZvXO7pT8U4JFbLO_wFp4qhDM30IKtyjxeXZ9Js0Ort-uWQ"
    );
    print('Latitude: ${result.latitude}, Longitude: ${result.longitude}, Longitude: ${token}');
    final databaseReference = FirebaseDatabase.instance.ref();
    final locationRef = databaseReference.child('locations').push();
    await locationRef.set({
      'token' : token,
      'latitude': result.latitude,
      'longitude': result.longitude
    });

    print("finished");
  } catch (error) {
    print("Error occurred while sending data: $error");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_userUid(), _signOutButton()],
        ),
      ),
    );
  }
}
