import 'package:flutter/material.dart';
import 'package:flutter_app/pages/config/app_config.dart';
import 'package:flutter_app/pages/home/home.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthDetermined = false;
  bool isAuthenticated = false;

  Future<void> lookup() async {
    try {
      isAuthenticated = true;
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pushReplacement(
          AppConfig.instance.currentContext!,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      });
    } catch (e) {
      isAuthenticated = false;
    } finally {
      isAuthDetermined = true;
      notifyListeners();
    }
  }
}
