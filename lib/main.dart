import 'package:flutter/material.dart';
import 'package:flutter_app/expense_tracker_app.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/provider/analytics_provider.dart';
import 'package:flutter_app/provider/auth_provider.dart';
import 'package:flutter_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => serviceLocator<AuthProvider>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ExpenseProvider>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<AnalyticsProvider>()),
      ],
      builder: (_, child) => const ExpenseTrackerApp(),
    );
  }
}
