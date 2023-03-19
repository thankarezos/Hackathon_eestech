import 'package:hello_ok/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../geo.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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

Future<void> sendData() async {
  try {
    Future<Position> position = determinePosition();
    Position result = await position;
    print('Latitude: ${result.latitude}, Longitude: ${result.longitude}');
    final databaseReference = FirebaseDatabase.instance.ref();
    final locationRef = databaseReference.child('locations').push();
    await locationRef.set({
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
          children: <Widget>[_userUid(), _signOutButton(),_senddata()],
        ),
      ),
    );
  }
}
