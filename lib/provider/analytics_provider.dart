import 'package:flutter/material.dart';

class AnalyticsProvider extends ChangeNotifier {
  final Map<String, String> details = {
    "food": "25%",
    "snacks": "35%",
    "travel": "45%",
    "movie": "55%",
    "self": "65%",
    "electronics": "75%",
    "others": "85%",
  };

  Map pieChartData = {
    "x": {
      "frequency": 1,
      "max": 6,
      "min": 1,
      "labels": ["food", "snacks", "travel", "movie", "self", "others"],
      "values": [
        {1: 2200.0},
        {2: 2400.0},
        {3: 1000.0},
        {4: 1400.0},
        {5: 2600.0},
        {6: 2200.0},
      ]
    },
    "y": {
      "frequency": 3000 / 7,
      "max": 3000,
      "min": 0,
    }
  };

  Map weeklyChartData = {
    "x": {
      "frequency": 1,
      "max": 7,
      "min": 1,
      "labels": ["sun", "mon", "tue", "wed", "thu", "fri", "sat"],
      "values": [
        {1: 1200.0},
        {2: 1400.0},
        {3: 1000.0},
        {4: 1000.0},
        {5: 2000.0},
        {6: 2200.0},
        {7: 2400.0}
      ]
    },
    "y": {
      "frequency": 3000 / 8,
      "max": 3000,
      "min": 0,
    }
  };
}
