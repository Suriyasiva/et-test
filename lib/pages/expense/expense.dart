import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/pages/common/add_expense_bottom_sheet.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/provider/expense_provider.dart';
import 'package:flutter_app/widget/m_button.dart';
import 'package:flutter_app/widget/space.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

const List<String> list = <String>[
  'Food',
  'Snacks',
  'Travel',
  'Movie',
];

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.dp5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.dp2),
              child: _timeLine(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppDimensions.dp10, top: 10),
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
            // Expanded(child: expenseListSecondry(context))
            // Expanded(child: expenseListV3())
            Expanded(child: slidableWidget())
          ],
        ),
      ),
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

  /* EasyDateTimeLine _timeLine() {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      timeLineProps: const EasyTimeLineProps(
          separatorPadding: 3,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppDimensions.dp10))),
          vPadding: AppDimensions.dp18),
      headerProps: EasyHeaderProps(
        monthPickerType: MonthPickerType.dropDown,
        monthStyle: TextStyle(
            color: AppColors.primary, // dropdown
            fontSize: AppDimensions.dp18,
            // backgroundColor: AppColors.greyBgDull,
            fontWeight: FontWeight.bold),
        selectedDateStyle: TextStyle(
            fontSize: AppDimensions.dp18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary),
        selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
      ),
      //
      dayProps: EasyDayProps(
        todayHighlightStyle: TodayHighlightStyle.withBackground,
        todayStyle: const DayStyle(
            dayNumStyle: TextStyle(fontSize: AppDimensions.dp20)),
        todayHighlightColor: AppColors.primary,
        inactiveDayStyle: DayStyle(
            borderRadius: 0,
            dayNumStyle: TextStyle(color: AppColors.primary),
            decoration: BoxDecoration(color: AppColors.greyBg)),
        activeDayStyle: DayStyle(
            decoration: BoxDecoration(
                color: AppColors.greyBg,
                borderRadius: BorderRadius.circular(AppDimensions.dp15),
                border: Border.all(width: 1, color: AppColors.primary)),
            dayStrStyle: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
            // monthStrStyle: TextStyle(color: AppColors.white),
            dayNumStyle: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.dp20)),
        dayStructure: DayStructure.dayStrDayNum,
      ),
      onDateChange: (selectedDate) {},
    );
  }

  */

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
                                children: list.map((String category) {
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

                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(top: AppDimensions.dp3),
                          //   child: DropdownMenu(
                          //     width: MediaQuery.of(context).size.width,
                          //     label: Text('Expense',
                          //         style: TextStyle(color: AppColors.primary)),
                          //     textStyle: TextStyle(color: AppColors.primary),
                          //     inputDecorationTheme: const InputDecorationTheme(
                          //       contentPadding:
                          //           EdgeInsets.symmetric(vertical: 2.0),
                          //     ),
                          //     initialSelection:
                          // provider.expenseData[index]['expense'] != ""
                          //     ? provider.expenseData[index]['expense']
                          //     : null,
                          //     onSelected: (value) {
                          //       provider.expenseData[index]['expense'] = value;
                          //     },
                          //     dropdownMenuEntries: list.map(
                          //       (String value) {
                          //         return DropdownMenuEntry(
                          //           value: value,
                          //           label: value,
                          //         );
                          //       },
                          //     ).toList(),
                          //   ),
                          // ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                style: TextStyle(color: AppColors.primary),
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
                  child: const Text('Add Expenses'),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget expenseListSecondry(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _expenseProvider.expenseHistory.keys.length,
      itemBuilder: (context, index) {
        final category = _expenseProvider.expenseHistory.keys.toList()[index];
        final expenses = _expenseProvider.expenseHistory[category];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimensions.dp10),
              child: Row(
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const HorizontalSpace(size: AppDimensions.dp10),
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpace(size: AppDimensions.dp8),
            for (final expense in expenses!)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.dp10,
                    vertical: AppDimensions.dp8),
                child: Row(
                  children: [
                    GlassContainer(
                      height: 50,
                      blur: 4,
                      color: Colors.white.withOpacity(1),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.10),
                          Colors.blue.withOpacity(0.10),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppDimensions.dp10)),
                        child: ElevatedButton(
                          onPressed: () {
                            editExpense(category);
                          }, // Keep onPressed for ElevatedButton to be enabled
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor: AppColors.greyBg,
                            backgroundColor:
                                Colors.transparent, // Text color when pressed
                          ),
                          child: Icon(Icons.edit, color: AppColors.primary),
                        ),
                      ),
                      // shadowStrength: 5,
                      // shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(16),
                      // shadowColor: Colors.white.withOpacity(0.24),
                    ),
                    const HorizontalSpace(size: AppDimensions.dp10),
                    Expanded(
                      child: GlassContainer(
                        height: 50,
                        blur: 4,
                        color: Colors.white.withOpacity(1),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.10),
                            Colors.blue.withOpacity(0.10),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: AppDimensions.dp10,
                                  top: AppDimensions.dp6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    expense["expenseName"].toLowerCase(),
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: AppDimensions.dp15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const VerticalSpace(size: AppDimensions.dp5),
                                  Text(
                                    "\$ ${expense["amount"]}",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: AppDimensions.dp12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const VerticalSpace(size: AppDimensions.dp3),
                                ],
                              ),
                            )
                          ],
                        ),
                        // shadowStrength: 5,
                        // shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(16),
                        // shadowColor: Colors.white.withOpacity(0.24),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget expenseListV3() {
    return Consumer<ExpenseProvider>(builder: (_, provider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.dp10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppDimensions.dp3),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 35,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: ["All", ...provider.expenseHistory.keys]
                      .map((String category) {
                    bool isSelectedChip =
                        provider.defaultFilterCategory == category;
                    return Container(
                      margin: const EdgeInsets.only(right: AppDimensions.dp5),
                      child: FilterChip(
                        showCheckmark: false,
                        selected: isSelectedChip,
                        selectedColor: AppColors.secondryV6,
                        backgroundColor: AppColors.secondryV2,
                        labelStyle: TextStyle(
                            color: isSelectedChip
                                ? AppColors.secondryV1
                                : AppColors.secondryV6,
                            fontWeight: FontWeight.w600),
                        label: Text(category),
                        onSelected: (isSelected) {
                          provider.filterExpenseCategory(category);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            provider.defaultFilterCategory == "All" &&
                    provider.expenseHistory.values.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.expenseHistory.values
                          .expand((list) => list)
                          .toList()
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        var allExpense = provider.expenseHistory.values
                            .expand((list) => list)
                            .toList();
                        var category = allExpense[index]["category"];
                        var amount = allExpense[index]["amount"];
                        return Dismissible(
                          confirmDismiss: (direction) async {
                            await editExpense(allExpense[index]["expenseName"]);
                            return false;
                          },
                          background: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Edit expense",
                                    style:
                                        TextStyle(color: AppColors.secondryV6)),
                                const HorizontalSpace(size: AppDimensions.dp5),
                                Icon(
                                  Icons.edit,
                                  color: AppColors.secondryV6,
                                ),
                              ],
                            ),
                          ),
                          key: UniqueKey(),
                          movementDuration: const Duration(milliseconds: 900),
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            if (direction == DismissDirection.endToStart) {
                              // Handle dismissal
                            }
                          },
                          child: Container(
                            height: 55,
                            margin: const EdgeInsets.only(
                                bottom: AppDimensions.dp8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimensions.dp30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(category,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppDimensions.dp15,
                                              color: AppColors.secondryV6)),
                                      Text(allExpense[index]["expenseName"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppDimensions.dp10,
                                              color: AppColors.secondryV4))
                                    ],
                                  ),
                                  Text(
                                    "\$ $amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondryV5),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : provider.expenseHistory[provider.defaultFilterCategory] !=
                            null &&
                        provider.expenseHistory[provider.defaultFilterCategory]!
                            .isNotEmpty &&
                        provider.defaultFilterCategory != "All"
                    ? Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: provider
                                  .expenseHistory[
                                      provider.defaultFilterCategory]
                                  ?.length ??
                              0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              confirmDismiss: (direction) async {
                                await editExpense("hello world");
                                return false;
                              },
                              background: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 16.0),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.amber,
                                ),
                              ),
                              key: UniqueKey(),
                              movementDuration:
                                  const Duration(milliseconds: 900),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.endToStart) {
                                  // Handle dismissal
                                }
                              },
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.only(
                                    bottom: AppDimensions.dp4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Center(
                                    child: Text(provider.expenseHistory[
                                            provider.defaultFilterCategory]
                                        ?[index]['expenseName'])),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text("No data")
          ],
        ),
      );
    });
  }

  Future editExpense(String expenseName) {
    Widget editExpenseWidget() {
      return Text(expenseName);
    }

    return bottomSheet(context, editExpenseWidget(), null);
  }

  Widget slidableWidget() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            dragDismissible: true,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                autoClose: true,
                borderRadius: BorderRadius.circular(AppDimensions.dp10),
                padding: const EdgeInsets.all(10),
                spacing: 10,
                icon: Icons.archive,
                label: 'Archive',
              ),
            ],
          ),
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: const ListTile(
                style: ListTileStyle.list,
                titleTextStyle: TextStyle(backgroundColor: Colors.amber),
                title: Text(
                  'Slide me',
                )),
          ),
        );
      },
    );
  }
}
