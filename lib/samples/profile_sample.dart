import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/UserData.dart';

class UserProfileScreen extends StatelessWidget {
  late String _name;

  Future<DocumentSnapshot> getSnapshot(DocumentReference doc) async {
    return await doc.get();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserModel>(context, listen: false);
    var doc = model.getUserDoc;
    doc.get().then((documentSnapshot) {
      // var data = documentSnapshot.data();
      _name =
          (documentSnapshot.data()! as Map<String, dynamic>)['name'] as String;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Background image
              Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
              ),
              // User profile
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Circular image
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/icon2.png'),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "$_name",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
