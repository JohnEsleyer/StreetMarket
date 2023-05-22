import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String? email;
  String? password;
  String? name;

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
