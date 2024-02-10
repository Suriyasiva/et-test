import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/pages/common/add_expense_bottom_sheet.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/provider/expense_provider.dart';
import 'package:flutter_app/widget/editable_input.dart';
import 'package:flutter_app/widget/m_button.dart';
import 'package:flutter_app/widget/space.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  late ExpenseProvider _expenseProvider;
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDay;
  DateTime _focusedDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  void handleExpense() {
    if (_formKey.currentState == null) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _expenseProvider.handleExpenses();
  }

  @override
  void initState() {
    _expenseProvider = serviceLocator<ExpenseProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondryV1,
      appBar: AppBar(
        backgroundColor: AppColors.secondryV1,
        toolbarHeight: AppDimensions.dp100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back",
                  style: TextStyle(
                      fontSize: AppDimensions.dp12,
                      color: AppColors.secondryV4),
                ),
                const VerticalSpace(size: AppDimensions.dp3),
                Text(
                  "Suriya Siva",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: AppColors.secondryV6),
                )
              ],
            ),
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
      ),
      body: Consumer<ExpenseProvider>(
          builder: (_, ExpenseProvider provider, child) {
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manage your",
                      style: TextStyle(
                          color: AppColors.secondryV6,
                          fontSize: AppDimensions.dp25,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "expenses",
                      style: TextStyle(
                          color: AppColors.secondryV6,
                          fontSize: AppDimensions.dp25,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            _timeLine(),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppDimensions.dp10, top: 10, right: AppDimensions.dp10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: AppDimensions.dp15,
                            horizontal: AppDimensions
                                .dp15), // Adjust the padding values as needed
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.dp25),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return AppColors.secondryV6; // Use the color you want
                        },
                      ),
                    ),
                    onPressed: () {
                      bottomSheet(context, addExpenseWidget(),
                          _expenseProvider.addExpenseField);
                    },
                    child: Text(
                      "Add Expense",
                      style: TextStyle(
                          color: AppColors.secondryV1,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              height: 35,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children:
                    ["All", ...provider.categories].map((String category) {
                  var selectedFilter =
                      provider.defaultFilterCategory == category;
                  return Container(
                    margin: const EdgeInsets.only(right: AppDimensions.dp5),
                    child: FilterChip(
                      labelStyle: TextStyle(
                          color: selectedFilter
                              ? AppColors.secondryV1
                              : AppColors.secondryV6,
                          fontWeight: FontWeight.w600),
                      showCheckmark: false,
                      selectedColor: AppColors.secondryV6,
                      backgroundColor: AppColors.secondryV2,
                      label: Text(category),
                      selected: selectedFilter ? true : false,
                      onSelected: (isSelected) {
                        provider.filterExpenseCategory(category);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(child: expenseListSecondry(context))
          ],
        );
      }),
    );
  }

  TableCalendar _timeLine() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDate,
      calendarStyle: CalendarStyle(
        todayTextStyle: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColors.secondryV6,
            fontSize: AppDimensions.dp18),
        todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.secondryV2,
            border: Border.all(width: 1, color: AppColors.secondryV5),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppDimensions.dp10))),
        selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.secondryV4,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppDimensions.dp10))),
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        weekendDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        holidayDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        outsideDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        withinRangeDecoration: const BoxDecoration(shape: BoxShape.rectangle),
        rangeStartDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppDimensions.dp4),
        ),
        rangeEndDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppDimensions.dp4),
        ),
        rangeHighlightColor: AppColors.secondryV3,
        weekendTextStyle: TextStyle(color: AppColors.secondryV4),
        defaultTextStyle: TextStyle(color: AppColors.secondryV4),
      ),
      headerStyle: HeaderStyle(
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.arrow_left_rounded,
            size: 30,
            color: AppColors.secondryV5,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_right_rounded,
            size: 30,
            color: AppColors.secondryV5,
          ),
          titleTextStyle: TextStyle(
              color: AppColors.secondryV5, fontWeight: FontWeight.bold)),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
              color: AppColors.secondryV5, fontWeight: FontWeight.bold),
          weekendStyle: TextStyle(
              color: AppColors.secondryV5, fontWeight: FontWeight.bold)),
      availableCalendarFormats: const {CalendarFormat.week: 'Week'},
      onFormatChanged: (format) {
        setState(() {
          calendarFormat = format;
        });
      },
      currentDay: DateTime.now(),
      calendarFormat: CalendarFormat.week,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDate = focusedDay;
        });
      },
    );
  }

  Widget expenseList() {
    return Consumer<ExpenseProvider>(builder: (_, provider, child) {
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 8,
          itemBuilder: (BuildContext context, index) {
            return const Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppDimensions.dp18),
                    bottomLeft: Radius.circular(AppDimensions.dp18),
                    bottomRight: Radius.circular(AppDimensions.dp4),
                    topLeft: Radius.circular(AppDimensions.dp18)),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Food',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.attach_money_rounded),
                          Text(
                            "200",
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ],
                      )
                    ],
                  ),
                  subtitle: Text(
                    'lapinoz pizza',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
            );
          });
    });
  }

  Widget addExpenseWidget() {
    return Consumer<ExpenseProvider>(
      builder: (_, provider, child) {
        return Column(
          children: [
            Form(
              key: _formKey,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.expenseData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(AppDimensions.dp10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Icon(Icons.cancel,
                                    color: AppColors.secondryV6),
                                onTap: () {
                                  provider.removeExpenseField(index);
                                },
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: AppDimensions.dp3),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              height: 35,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children:
                                    provider.categories.map((String category) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        right: AppDimensions.dp5),
                                    child: FilterChip(
                                      labelStyle: TextStyle(
                                          color: provider.expenseData[index]
                                                      ['expense'] ==
                                                  category
                                              ? AppColors.secondryV1
                                              : AppColors.secondryV6,
                                          fontWeight: FontWeight.w600),
                                      showCheckmark: false,
                                      selectedColor: AppColors.secondryV6,
                                      backgroundColor: AppColors.secondryV2,
                                      label: Text(category),
                                      selected: provider.expenseData[index]
                                                  ['expense'] ==
                                              category
                                          ? true
                                          : false,
                                      onSelected: (isSelected) {
                                        provider.handleExpenseCategory(
                                            index, category);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                style: TextStyle(color: AppColors.secondryV6),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'required';
                                  }

                                  provider.expenseData[index]['amount'] = value;

                                  return null;
                                },
                                decoration: const InputDecoration(
                                    label: Text('    Expense Name'),
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              )),
                              const HorizontalSpace(size: AppDimensions.dp10),
                              Expanded(
                                  child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9\.]")),
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'required';
                                  }

                                  provider.expenseData[index]['amount'] = value;

                                  return null;
                                },
                                decoration: const InputDecoration(
                                    label: Text('    Expense Amount'),
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              )),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.dp8),
              child: SizedBox(
                width: double.infinity,
                child: MButton(
                  isLoading: false,
                  onPressed: handleExpense,
                  child: Text(
                    'Add Expenses',
                    style: TextStyle(color: AppColors.secondryV1),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget expenseListSecondry(BuildContext context) {
    final expenseData = _expenseProvider.expenseHistory.values.toList();
    final expenseFlatList = expenseData.expand((list) => list).toList();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: expenseFlatList.length,
      itemBuilder: (context, index) {
        final expense = expenseFlatList[index];
        return slidableWidget(expense, index);
      },
    );
  }

  Future editExpense(index) {
    Widget editExpenseWidget() {
      return Consumer<ExpenseProvider>(
          builder: (_, ExpenseProvider provider, child) {
        return Padding(
          padding: const EdgeInsets.all(AppDimensions.dp10),
          child: Column(
            children: [
              const VerticalSpace(size: AppDimensions.dp10),
              Padding(
                padding: const EdgeInsets.only(top: AppDimensions.dp3),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 35,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: provider.categories.map((String categoryData) {
                      return Container(
                        margin: const EdgeInsets.only(right: AppDimensions.dp5),
                        child: FilterChip(
                          labelStyle: TextStyle(
                              color: categoryData ==
                                      provider.editExpenseCategory["category"]
                                  ? AppColors.secondryV1
                                  : AppColors.secondryV6,
                              fontWeight: FontWeight.w600),
                          showCheckmark: false,
                          selectedColor: AppColors.secondryV6,
                          backgroundColor: AppColors.secondryV2,
                          label: Text(categoryData),
                          selected: categoryData ==
                                  provider.editExpenseCategory["category"]
                              ? true
                              : false,
                          onSelected: (isSelected) {
                            provider.updateSelectedExpense({
                              ...provider.editExpenseCategory,
                              "category": categoryData
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              EditableInput(
                isRequired: true,
                label: "Expense Name",
                value: provider.editExpenseCategory["expenseName"],
                onSave: (value) {
                  provider.updateSelectedExpense(
                      {...provider.editExpenseCategory, "expenseName": value});
                },
              ),
              EditableInput(
                isRequired: true,
                label: "Expense",
                value: provider.editExpenseCategory["amount"].toString(),
                onSave: (value) {
                  provider.updateSelectedExpense(
                      {...provider.editExpenseCategory, "amount": value});
                },
              ),
              const VerticalSpace(size: AppDimensions.dp50),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppDimensions.dp10,
                    top: 10,
                    right: AppDimensions.dp10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: AppDimensions.dp13,
                            horizontal: AppDimensions
                                .dp15), // Adjust the padding values as needed
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.dp25),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return AppColors.secondryV6; // Use the color you want
                        },
                      ),
                    ),
                    onPressed: () {
                      provider.updateExpense();
                    },
                    child: Text(
                      "update Expense",
                      style: TextStyle(
                          color: AppColors.secondryV1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    return bottomSheet(context, editExpenseWidget(), null);
  }

  Widget slidableWidget(expense, index) {
    return Slidable(
      key: const ValueKey(0),
      closeOnScroll: true,
      endActionPane: ActionPane(
        dragDismissible: true,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              _expenseProvider.editCategory = expense["category"];
              _expenseProvider.updateSelectedExpense(expense);
              editExpense(index);
            },
            backgroundColor: AppColors.secondryV1,
            foregroundColor: AppColors.secondryV6,
            autoClose: true,
            borderRadius: BorderRadius.circular(AppDimensions.dp20),
            icon: Icons.edit,
            label: 'Edit expense',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 65,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.secondryV2,
              borderRadius: BorderRadius.circular(AppDimensions.dp20),
              border: Border.all(
                color: AppColors.secondryV2,
                width: 3,
              )),
          child: expense?.keys?.length != 0
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(expense["category"]!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondryV6)),
                          const VerticalSpace(size: 2),
                          Text(expense["expenseName"]!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondryV5))
                        ],
                      ),
                      Text("\$ ${expense["amount"]!.toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.green))
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
