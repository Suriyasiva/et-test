import 'package:flutter/material.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/widget/space.dart';

Future bottomSheet(
    BuildContext context, Widget formWidget, VoidCallback? addExpenseField) {
  return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.dp20),
            topRight: Radius.circular(AppDimensions.dp20)),
      ),
      // backgroundColor: AppColors.greyBg,
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          height: 550,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const VerticalSpace(size: AppDimensions.dp3),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.dp5),
                  width: AppDimensions.dp140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.dp5),
                    color: AppColors.secondryV6,
                    // boxShadow: [
                    //   BoxShadow(color: Colors.grey.shade200, spreadRadius: 1),
                    // ],
                  ),
                ),
              ),
              const VerticalSpace(size: AppDimensions.dp15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  addExpenseField != null
                      ? Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.secondryV5,
                            ),
                            TextButton(
                                onPressed: () {
                                  addExpenseField();
                                },
                                child: Text(
                                  "Add Expense Field",
                                  style: TextStyle(color: AppColors.secondryV5),
                                ))
                          ],
                        )
                      : const SizedBox.shrink(),
                  const HorizontalSpace(size: AppDimensions.dp10)
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: formWidget,
                ),
              ),
            ],
          ),
        );
      });
}
