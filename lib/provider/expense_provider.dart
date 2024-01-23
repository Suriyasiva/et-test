import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Map> expenseData = [
    {"expense": "", "amount": 0, "expenseType": ""}
  ];

  String defaultFilterCategory = "All";

  Map<String, List> expenseHistory = {
    "Food": [
      {
        "expenseName": "golden corn lapinoz Pizza",
        "amount": 200,
        "category": "Food"
      },
      {"expenseName": "non-veg full meals", "amount": 300, "category": "Food"},
      {"expenseName": "supper", "amount": 200, "category": "Food"}
    ],
    "Snacks": [
      {"expenseName": "juice", "amount": 200, "category": "Snacks"},
      {"expenseName": "chicken grill", "amount": 400, "category": "Snacks"},
    ],
    "Travel": [
      {"expenseName": "airport", "amount": 100, "category": "Travel"},
      {"expenseName": "cab-office", "amount": 50, "category": "Travel"},
    ],
    "Rent": [
      {"expenseName": "room rent", "amount": 100, "category": "Rent"},
    ],
    "Electronics": [
      {"expenseName": "headset", "amount": 600, "category": "Electronics"},
      {"expenseName": "charger", "amount": 500, "category": "Electronics"},
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
}
