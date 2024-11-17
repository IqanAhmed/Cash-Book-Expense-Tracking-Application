import 'package:cash_book_expense_tracker/provider/category_data_provider.dart';
import 'package:cash_book_expense_tracker/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/transaction_data_provider.dart';
import 'screens/home_screen/home_screen_body.dart';
import 'screens/home_screen/income_expense_detail_screen/income_expense_detail_screen_body.dart';
import 'utils/themes_data.dart';

void main() {
  runApp(const MyApp()
      // )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TransactionDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryDataProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blueAccent,
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
            ),
            timePickerTheme:
                const TimePickerThemeData(backgroundColor: Colors.white),
            appBarTheme: AppBarTheme(color: lightThemeScaffold),
            drawerTheme: DrawerThemeData(
                backgroundColor: lightThemeDrawerBackgroundColor),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    textStyle: const WidgetStatePropertyAll(TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: font3)),
                    foregroundColor: WidgetStatePropertyAll(
                      selectDark,
                    ))),
            secondaryHeaderColor: lightThemeSecondaryFont,
            scaffoldBackgroundColor: lightThemeScaffold),
        initialRoute: routeSplash,
        routes: {
          routeSplash: (context) => const MySplashScreen(),
          routeHome: (context) => const MyHomeScreenBody(),
          routeIEScreen: (context) => const MyIncomeExpenseDetailScreenBody(),
        },
      ),
    );
  }
}
