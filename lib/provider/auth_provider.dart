import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth/passcode.dart';
import 'package:flutter_app/pages/config/app_config.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/splash/splash.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthDetermined = false;
  bool isAuthenticated = false;

  Map currentUser = {"name": "", "email": "", "phoneNumber": "", "pin": ""};

  handleUserData() async {
    print(currentUser);
    Navigator.pushReplacement(
      AppConfig.instance.currentContext!,
      MaterialPageRoute(
        builder: (_) => const PassCodeLogin(),
      ),
    );
  }

  navigateToHome() {
    Navigator.pushReplacement(
      AppConfig.instance.currentContext!,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  navigateToSplash() {
    Navigator.pushReplacement(
      AppConfig.instance.currentContext!,
      MaterialPageRoute(
        builder: (_) => const SplashPage(),
      ),
    );
    lookup();
  }

  Future<void> lookup() async {
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        isAuthenticated = true;
        navigateToHome();
      });
    } catch (e) {
      isAuthenticated = false;
      handleUserData();
    } finally {
      isAuthDetermined = true;
      notifyListeners();
    }
  }
}
