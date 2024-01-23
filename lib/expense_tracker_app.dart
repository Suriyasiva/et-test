import 'package:flutter/material.dart';
import 'package:flutter_app/pages/config/app_config.dart';
import 'package:flutter_app/pages/splash/splash.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      navigatorKey: AppConfig.instance,
      // title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.roboto(textStyle: textTheme.bodyMedium),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
