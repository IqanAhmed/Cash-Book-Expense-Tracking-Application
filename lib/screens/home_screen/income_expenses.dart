// ignore_for_file: non_constant_identifier_names

import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/transaction_data_provider.dart';
import '../../widgets/gradient_box.dart';

class MyIncomeExpenses extends StatefulWidget {
  const MyIncomeExpenses({super.key});

  @override
  State<MyIncomeExpenses> createState() => _MyIncomeExpensesState();
}

class _MyIncomeExpensesState extends State<MyIncomeExpenses> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDataProvider>(
      builder: (context, value, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GradientBox(
              amountEnable: true,
              amount: value.TotalIncome(),
              title: "Income",
              gradient1: incomeDark,
              gradient2: incomeLight,
              openDetail: () {
                if (value.TotalIncome() != 0) {
                  Navigator.pushNamed(context, routeIEScreen, arguments: [
                    GradientBox(
                        amountEnable: true,
                        amount: value.TotalIncome(),
                        title: "Income",
                        gradient1: incomeDark,
                        gradient2: incomeLight,
                        openDetail: null),
                    "Income"
                  ]);
                }
              }),
          GradientBox(
            amountEnable: true,
            amount: value.TotalExpense(),
            title: "Expense",
            gradient1: expenseDark,
            gradient2: expenseLight,
            openDetail: () {
              if (value.TotalExpense() != 0) {
                Navigator.pushNamed(context, routeIEScreen, arguments: [
                  GradientBox(
                      amountEnable: true,
                      amount: value.TotalExpense(),
                      title: "Expense",
                      gradient1: expenseDark,
                      gradient2: expenseLight,
                      openDetail: null),
                  "Expense"
                ]);
              }
            },
          ),
        ],
      ),
    );
  }
}
