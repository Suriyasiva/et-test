import 'package:flutter/material.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/provider/auth_provider.dart';
import 'package:flutter_app/widget/space.dart';
import 'package:pinput/pinput.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late AuthProvider authProvider;
  final _formKey = GlobalKey<FormState>();
  final _pinFormKey = GlobalKey<FormState>();
  int _index = 0;

  String confirmPin = "";

  void handleExpense() {
    if (_formKey.currentState == null) {
      setState(() {
        _index = 0;
      });
      return;
    }

    if (!_formKey.currentState!.validate()) {
      setState(() {
        _index = 0;
      });
      return;
    }

    if (_pinFormKey.currentState == null) {
      setState(() {
        _index = 1;
      });
      return;
    }

    if (!_pinFormKey.currentState!.validate()) {
      setState(() {
        _index = 1;
      });
      return;
    }

    authProvider.handleUserData();
  }

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
            Text(
              "Welcome to Spendly logs  🙌",
              style: TextStyle(
                  color: AppColors.secondryV6,
                  fontSize: AppDimensions.dp20,
                  fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Row(
                    children: <Widget>[
                      _index == 0
                          ? TextButton(
                              onPressed: details.onStepContinue,
                              child: const Text('Next'),
                            )
                          : TextButton(
                              onPressed: details.onStepContinue,
                              child: const Text('Finish'),
                            ),
                    ],
                  );
                },
                currentStep: _index,
                onStepContinue: () {
                  if (_index <= 0) {
                    setState(() {
                      _index += 1;
                    });
                  }

                  if (_index == 1) {
                    handleExpense();
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: <Step>[
                  Step(
                    stepStyle: StepStyle(color: AppColors.secondryV6),
                    title: const Text('Identity Credentials'),
                    content: identityCredentials(),
                  ),
                  Step(
                    stepStyle: StepStyle(color: AppColors.secondryV6),
                    title: const Text('Security Credentials'),
                    content: pinCredentials(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget identityCredentials() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          style: TextStyle(color: AppColors.secondryV6),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'required';
            }
            authProvider.currentUser["name"] = value;
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        TextFormField(
          style: TextStyle(color: AppColors.secondryV6),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'required';
            }
            authProvider.currentUser["email"] = value;
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        TextFormField(
          style: TextStyle(color: AppColors.secondryV6),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'required';
            }
            authProvider.currentUser["phoneNumber"] = value;
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget pinCredentials() {
    return Form(
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
              authProvider.currentUser["pin"] = value;
            },
          ),
        ],
      ),
    );
  }
}
