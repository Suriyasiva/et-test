import 'package:flutter/material.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/provider/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthProvider _authProvider;
  @override
  void initState() {
    super.initState();
    _authProvider = serviceLocator<AuthProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authProvider.lookup();
    });
  }

//  DashboardPage(index: NavigationIndex.homePage)
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
