import 'package:flutter/material.dart';
import 'package:flutter_app/pages/account/account.dart';
import 'package:flutter_app/pages/analytics/analytics.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/expense/expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.secondryV1,
          iconSize: 25,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPageIndex,
          selectedItemColor: AppColors.secondryV6,
          unselectedItemColor: AppColors.secondryV4,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist_rtl_rounded),
              label: 'Expense',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: 'User',
            ),
          ],
        ),
        body: const <Widget>[
          Expense(),
          Analytics(),
          MyAccount()
        ][currentPageIndex]);
  }
}
