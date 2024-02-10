import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  String name = "suriya";
  String email = "suriya@yopmail.com";
  String phoneNumber = "9789412582";
  String pin = "1234";

  onSave(key, value) {
    // todo : use MAP in user data to avoid switch case
    switch (key) {
      case "name":
        name = value;
      case "email":
        email = value;
      case "phoneNumber":
        phoneNumber = value;
      case "pin":
        pin = value;
      default:
        return;
    }

    notifyListeners();
  }
}
