import 'package:flutter_app/provider/account_provider.dart';
import 'package:flutter_app/provider/analytics_provider.dart';
import 'package:flutter_app/provider/auth_provider.dart';
import 'package:flutter_app/provider/expense_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();

  //SERVICE

  serviceLocator.registerLazySingleton(() => pref);

  //PROVIDERS
  serviceLocator.registerLazySingleton<AuthProvider>(() => AuthProvider());
  serviceLocator
      .registerLazySingleton<ExpenseProvider>(() => ExpenseProvider());
  serviceLocator
      .registerLazySingleton<AnalyticsProvider>(() => AnalyticsProvider());
  serviceLocator
      .registerLazySingleton<AccountProvider>(() => AccountProvider());
}
