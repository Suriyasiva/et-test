import 'package:flutter/material.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/provider/auth_provider.dart';
import 'package:flutter_app/widget/space.dart';
import 'package:pinput/pinput.dart';

class PassCodeLogin extends StatefulWidget {
  const PassCodeLogin({super.key});

  @override
  State<PassCodeLogin> createState() => _PassCodeLoginState();
}

class _PassCodeLoginState extends State<PassCodeLogin> {
  late AuthProvider authProvider;
  final _pinFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    authProvider = serviceLocator<AuthProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondryV1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _pinFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Security Pin"),
                  const VerticalSpace(size: 10),
                  Pinput(
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'required';
                      }
                      return null;
                    },
                    onCompleted: (value) {
                      authProvider.navigateToSplash();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
