import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Map> expenseData = [
    {"expense": "", "amount": 0, "expenseType": ""}
  ];

  List<String> categories = [
    "Food",
    "Snacks",
    "Travel",
    "Rent",
    "Electronics",
    "Others"
  ];

  String defaultFilterCategory = "All";

  Map editExpenseCategory = {};

  String? editCategory;

  Map<String, List> expenseHistory = {
    "Food": [
      {
        "id": 1,
        "expenseName": "golden corn lapinoz Pizza",
        "amount": 200,
        "category": "Food"
      },
      {
        "id": 2,
        "expenseName": "non-veg full meals",
        "amount": 300,
        "category": "Food"
      },
      {"id": 3, "expenseName": "supper", "amount": 200, "category": "Food"}
    ],
    "Snacks": [
      {"expenseName": "juice", "id": 12, "amount": 200, "category": "Snacks"},
      {
        "expenseName": "chicken grill",
        "id": 43,
        "amount": 400,
        "category": "Snacks"
      },
    ],
    "Travel": [
      {"expenseName": "airport", "id": 8, "amount": 100, "category": "Travel"},
      {
        "expenseName": "cab-office",
        "id": 9,
        "amount": 50,
        "category": "Travel"
      },
    ],
    "Rent": [
      {"expenseName": "room rent", "id": 98, "amount": 100, "category": "Rent"},
    ],
    "Electronics": [
      {
        "expenseName": "headset",
        "id": 776,
        "amount": 600,
        "category": "Electronics"
      },
      {
        "expenseName": "charger",
        "id": 456,
        "amount": 500,
        "category": "Electronics"
      },
    ],
    "Others": [
      // {"expenseName": "dsa-book", "amount": 200}
    ],
  };

  void addExpenseField() {
    expenseData.add({"expense": "", "amount": 0, "expenseType": ""});
    notifyListeners();
  }

  void handleExpenseCategory(index, category) {
    expenseData[index]['expense'] = category;
    notifyListeners();
  }

  void filterExpenseCategory(category) {
    defaultFilterCategory = category;
    notifyListeners();
  }

  void removeExpenseField(index) {
    if (expenseData.length <= 1) {
      return;
    }
    expenseData.removeAt(index);
    notifyListeners();
  }

  void handleExpenses() {
    print(expenseData);
  }

  void updateExpense() {
    print(editCategory);
    List getExpenseList = expenseHistory[editCategory]!;
    List updatedList = getExpenseList.where((expense) {
      return expense["category"] == editCategory;
    }).toList();
    print(updatedList);
    // print(editExpenseCategory);
  }

  void handleCategoryFilter() {}

  void updateSelectedExpense(expense) {
    editExpenseCategory = expense;
    notifyListeners();
  }
}
