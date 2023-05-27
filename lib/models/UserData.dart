import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String name = "";

  late UserCredential _userCred;
  late CollectionReference _userCollection;
  late DocumentReference _userDoc;

  void setUserEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  UserCredential get getUserCred => _userCred;
  CollectionReference get getUserCollection => _userCollection;
  DocumentReference get getUserDoc => _userDoc;

  void setUserDoc(DocumentReference doc) {
    this._userDoc = doc;
  }

  void setUserCollection(CollectionReference usrCollection) {
    this._userCollection = usrCollection;
  }

  void setUserCred(UserCredential usr) {
    this._userCred = usr;
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
