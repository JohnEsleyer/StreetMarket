import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/UserData.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                  'Sign in',
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
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/register');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(width: 50),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
