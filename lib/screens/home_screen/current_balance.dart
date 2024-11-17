// ignore_for_file: non_constant_identifier_names

import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:provider/provider.dart';
import '../../provider/transaction_data_provider.dart';

class MyCurrentBalance extends StatefulWidget {
  const MyCurrentBalance({super.key});

  @override
  State<MyCurrentBalance> createState() => _MyCurrentBalanceState();
}

class _MyCurrentBalanceState extends State<MyCurrentBalance> {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<TransactionDataProvider>(
      builder: (context, value, child) => Center(
        child: Container(
          margin: const EdgeInsets.all(2),
          // margin: EdgeInsets.symmetric(
          //     horizontal: 15, vertical: screenHeight * 0.04),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedFlipCounter(
                  value: value.CurrentBalance(),
                  prefix: "\$",
                  duration: const Duration(milliseconds: 1000),
                  textStyle: const TextStyle(
                      fontFamily: font1,
                      fontSize: 34,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Current Balance",
                  style: TextStyle(
                      fontFamily: font1,
                      letterSpacing: 1,
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// https://pub.dev/packages/animated_flip_counter