import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String name = "";

  late FirebaseAuth auth;
  late FirebaseFirestore db;

  UserModel({required this.auth, required this.db});
  void setUserEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setUserPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setUserName(String name) {
    this.name = name;
    notifyListeners();
  }
}
