import 'package:flutter/material.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/provider/account_provider.dart';
import 'package:flutter_app/widget/editable_input.dart';
import 'package:flutter_app/widget/space.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late AccountProvider accountProvider;

  @override
  void initState() {
    accountProvider = serviceLocator<AccountProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: IconButton(
        onPressed: () {},
        color: Colors.redAccent,
        icon: const Icon(Icons.power_settings_new),
      ),
      backgroundColor: AppColors.secondryV1,
      appBar: AppBar(
        backgroundColor: AppColors.secondryV1,
        toolbarHeight: AppDimensions.dp100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Account",
              style: TextStyle(
                color: AppColors.secondryV6,
                fontSize: AppDimensions.dp25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VerticalSpace(size: AppDimensions.dp5),
            Consumer<AccountProvider>(
                builder: (_, AccountProvider provider, child) {
              return Text(
                " hi ${accountProvider.name} 👋 ",
                style: TextStyle(
                    color: AppColors.secondryV4,
                    fontSize: AppDimensions.dp15,
                    fontWeight: FontWeight.bold),
              );
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.dp10),
        child: Consumer<AccountProvider>(
          builder: (_, AccountProvider provider, child) {
            return Column(
              children: [
                const VerticalSpace(size: AppDimensions.dp10),
                EditableInput(
                  isRequired: true,
                  label: "Name",
                  value: provider.name,
                  onSave: (value) {
                    provider.onSave("name", value);
                    // provider.name = value;
                  },
                ),
                EditableInput(
                  isRequired: true,
                  label: "Email",
                  value: provider.email,
                  onSave: (value) {
                    provider.onSave("email", value);
                    // provider.name = value;
                  },
                ),
                EditableInput(
                  isRequired: true,
                  label: "Phone Number",
                  value: provider.phoneNumber,
                  onSave: (value) {
                    provider.onSave("phoneNumber", value);
                    // provider.name = value;
                  },
                ),
                EditableInput(
                  isRequired: true,
                  label: "Pin",
                  value: provider.pin,
                  onSave: (value) {
                    provider.onSave("pin", value);
                    // provider.name = value;
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
