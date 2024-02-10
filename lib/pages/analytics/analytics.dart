import 'package:flutter/material.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/provider/analytics_provider.dart';
import 'package:flutter_app/widget/space.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  String? selectedOption = 'week';
  bool barChart = false;

  late AnalyticsProvider _analyticsProvider;

  void updateBarChart(bool value) {
    setState(() {
      barChart = value;
    });
  }

  @override
  void initState() {
    _analyticsProvider = serviceLocator<AnalyticsProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondryV1,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.dp10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                barChart
                    ? DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          value: selectedOption,
                          dropdownColor: AppColors.greyBg,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (filterValue) {
                            setState(() {
                              selectedOption = filterValue;
                            });
                          },
                          items: <String>['yearly', 'week', 'day', 'custom']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : Container(
                        height: AppDimensions.dp48,
                      )
              ],
            ),
          ),
          const VerticalSpace(size: AppDimensions.dp38),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.dp25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expenses",
                        style: TextStyle(
                            color: AppColors.secondryV6,
                            fontSize: AppDimensions.dp25,
                            fontWeight: FontWeight.bold),
                      ),
                      const VerticalSpace(size: AppDimensions.dp5),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: '\$8080',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondryV5,
                                  fontSize: AppDimensions.dp30),
                            ),
                            TextSpan(
                              text: '/week',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.secondryV5),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 320.0,
                maxWidth: 600.0,
              ),
              padding: const EdgeInsets.all(24.0),
              child: Chart(
                layers: barChart ? layers() : pieChart(),
                padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(
                  bottom: 12.0,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              barChart
                  ? Text(
                      "Week wise",
                      style: TextStyle(color: AppColors.secondryV6),
                    )
                  : Text(
                      "Expense wise",
                      style: TextStyle(color: AppColors.secondryV6),
                    ),
              Switch(
                inactiveTrackColor: AppColors.secondryV4,
                value: barChart,
                activeColor: AppColors.secondryV4,
                onChanged: (bool value) {
                  updateBarChart(value);
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.dp25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Details",
                  style: TextStyle(
                      color: AppColors.secondryV6, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          categoryWise()
        ]),
      ),
    );
  }

  List<ChartLayer> layers() {
    return [
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency:
                _analyticsProvider.weeklyChartData["x"]["frequency"].toDouble(),
            max: _analyticsProvider.weeklyChartData["x"]["max"].toDouble(),
            min: _analyticsProvider.weeklyChartData["x"]["min"].toDouble(),
            textStyle: TextStyle(
              color: AppColors.secondryV4,
              fontSize: AppDimensions.dp10,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency:
                _analyticsProvider.weeklyChartData["y"]["frequency"].toDouble(),
            max: _analyticsProvider.weeklyChartData["y"]["max"].toDouble(),
            min: _analyticsProvider.weeklyChartData["y"]["min"].toDouble(),
            textStyle: TextStyle(
              color: AppColors.secondryV4,
              fontSize: AppDimensions.dp10,
            ),
          ),
        ),
        labelX: (value) {
          return _analyticsProvider.weeklyChartData["x"]["labels"]
                  [value.toInt() - 1]
              .toString();
        },
        labelY: (value) => value.toInt().toString(),
      ),
      ChartBarLayer(
        items: (_analyticsProvider.weeklyChartData["x"]['values']
                as List<Map<dynamic, dynamic>>)
            .map((e) {
          final key = e.keys.first;
          final value = e.values.first;
          return ChartBarDataItem(
            color: AppColors.secondryV6,
            value: double.parse(value.toString()),
            x: double.parse(key.toString()),
          );
        }).toList(),
        settings: const ChartBarSettings(
          thickness: AppDimensions.dp8,
          radius: BorderRadius.all(Radius.circular(AppDimensions.dp4)),
        ),
      ),
    ];
  }

  List<ChartLayer> pieChart() {
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

    return [
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: pieChartData["x"]["frequency"].toDouble(),
            max: pieChartData["x"]["max"].toDouble(),
            min: pieChartData["x"]["min"].toDouble(),
            textStyle: TextStyle(
              color: AppColors.secondryV5,
              fontSize: AppDimensions.dp10,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: pieChartData["y"]["frequency"].toDouble(),
            max: pieChartData["y"]["max"].toDouble(),
            min: pieChartData["y"]["min"].toDouble(),
            textStyle: TextStyle(
              color: AppColors.secondryV5,
              fontSize: AppDimensions.dp10,
            ),
          ),
        ),
        labelX: (value) {
          return pieChartData["x"]["labels"][value.toInt() - 1].toString();
        },
        labelY: (value) => value.toInt().toString(),
      ),
      ChartBarLayer(
        items: (pieChartData["x"]['values'] as List<Map<dynamic, dynamic>>)
            .map((e) {
          final key = e.keys.first;
          final value = e.values.first;
          return ChartBarDataItem(
            color: AppColors.secondryV6,
            value: double.parse(value.toString()),
            x: double.parse(key.toString()),
          );
        }).toList(),
        settings: const ChartBarSettings(
          thickness: AppDimensions.dp8,
          radius: BorderRadius.all(Radius.circular(AppDimensions.dp4)),
        ),
      ),
    ];
  }

  Widget categoryWise() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2, // Set height as needed
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: _analyticsProvider.details.entries.map((entry) {
          double percentage =
              double.parse(entry.value.replaceAll('%', '')) / 100;
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.dp5),
              boxShadow: [
                BoxShadow(color: AppColors.secondryV2, spreadRadius: 1),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: percentage,
                  center: Text(entry.value),
                  progressColor: AppColors.secondryV5,
                ),
                const VerticalSpace(size: AppDimensions.dp15),
                Row(
                  children: [
                    Text(
                      entry.key.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondryV6,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            // Text(
            //   entry.key.toUpperCase(),
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: AppColors.secondryV6,
            //     fontSize: 16,
            //   ),
            // ),
            //     const SizedBox(height: 8),
            //     Text(
            //       entry.value,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //         color: AppColors.secondryV5,
            //       ),
            //     ),
            //   ],
            // ),
          );
        }).toList(),
      ),
    );
  }
}
