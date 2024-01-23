import 'package:flutter/material.dart';
import 'package:flutter_app/pages/analytics/analytics.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/pages/expense/expense.dart';
import 'package:flutter_app/widget/space.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.secondryV1,
              title: Padding(
                padding:
                    const EdgeInsets.only(top: AppDimensions.dp15, bottom: 5),
                child: Row(children: [
                  Container(
                    margin: const EdgeInsets.only(top: AppDimensions.dp5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.dp6,
                        vertical: AppDimensions.dp6),
                    decoration: BoxDecoration(
                        color: AppColors.secondryV2,
                        borderRadius: BorderRadius.circular(AppDimensions.dp10),
                        border:
                            Border.all(width: 1, color: AppColors.secondryV5)),
                    child: Text(
                      "SS",
                      style: TextStyle(
                          color: AppColors.secondryV6,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: AppDimensions.dp5, left: AppDimensions.dp10),
                    width: 3,
                    height: 30,
                    decoration: BoxDecoration(
                        color: AppColors.secondryV5,
                        borderRadius: BorderRadius.circular(AppDimensions.dp10),
                        border: Border.all(
                          color: AppColors.secondryV5,
                          width: 3,
                        )),
                  ),
                  const HorizontalSpace(size: AppDimensions.dp10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "hi, Suriya",
                        style: TextStyle(
                            color: AppColors.secondryV6,
                            fontSize: AppDimensions.dp18),
                      ),
                      const VerticalSpace(size: 3),
                      Text(
                        "welcome back, Track your expense here.",
                        style: TextStyle(
                            fontSize: AppDimensions.dp10,
                            color: AppColors.secondryV4),
                      )
                    ],
                  )
                ]),
              ),
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: AppDimensions.dp15),
                  child: IconButton(
                    onPressed: () {},
                    color: Colors.redAccent,
                    icon: const Icon(Icons.power_settings_new),
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.secondryV1,
              iconSize: 25,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentPageIndex,
              selectedItemColor: AppColors.secondryV6,
              unselectedItemColor: AppColors.secondryV4,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.bold),
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
              Text("user")
            ][currentPageIndex]));
  }
}
