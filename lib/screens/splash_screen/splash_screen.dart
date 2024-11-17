import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/databasehelper.dart';
import '../../provider/transaction_data_provider.dart';
import '../../utils/themes_data.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  int builde = 0;
  void initialize() {
    Future.delayed(const Duration(seconds: 1, milliseconds: 400)).then((value) {
      Provider.of<TransactionDataProvider>(context, listen: false)
          .initializeDatabase();
      Navigator.of(context).pushReplacementNamed(routeHome);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (builde == 0) {
      builde++;
      DatabaseHelper.instance.getData();
      initialize();
    }
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 70,
        height: 70,
        child: Image.asset("assets/cashbook/cashbook.png"),
      ),
    ));
  }
}
