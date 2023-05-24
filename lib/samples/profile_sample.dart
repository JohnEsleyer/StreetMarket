import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/UserData.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background image
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          // User profile
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular image
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/icon2.png'),
              ),
              SizedBox(height: 16),
              // User's name
              Text(
                Provider.of<UserModel>(context, listen: false).name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
