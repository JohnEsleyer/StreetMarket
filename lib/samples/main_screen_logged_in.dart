import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/UserData.dart';

class MainScreenLoggedIn extends StatefulWidget {
  @override
  _MainScreenLoggedInState createState() => _MainScreenLoggedInState();
}

class _MainScreenLoggedInState extends State<MainScreenLoggedIn> {
  User? user;
  String profileURL = "";
  @override
  void initState() {
    super.initState();

    // Initialize Firebase Authentication
    FirebaseAuth auth = FirebaseAuth.instance;

    // Get the current user
    setState(() {
      user = auth.currentUser;
    });

    // Get the reference to the image from Firebase Storage
    Reference imageRef =
        FirebaseStorage.instance.ref().child('users/${user?.uid}/profile.jpg');

    // Get the download URL for the image
    imageRef.getDownloadURL().then((url) {
      setState(() {
        // Create an Image widget with the download URL
        profileURL = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 222, 182, 0),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 30),
                Image.asset(
                  'assets/streetmarket_icon.png',
                  width: 30,
                  height: 30,
                ),
                Image.asset(
                  'assets/streetmarket_text.png',
                  width: 150,
                  height: 150,
                ),
              ],
            ),
            Container(
              height: 35,
              width: 35,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/profile');
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(profileURL),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
