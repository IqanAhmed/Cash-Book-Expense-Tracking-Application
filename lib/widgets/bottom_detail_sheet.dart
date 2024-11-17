// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:cash_book_expense_tracker/provider/transaction_data_provider.dart';
import 'package:cash_book_expense_tracker/screens/home_screen/add_new_transaction/add_new_transaction.dart';
import 'package:cash_book_expense_tracker/utils/date_and_time_formatter.dart';
import 'package:cash_book_expense_tracker/utils/variables.dart';
import 'package:cash_book_expense_tracker/widgets/circular_gradient_icon_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import '../provider/category_data_provider.dart';
import '../provider/models/transaction_model.dart';
import 'alert_dialog.dart';

OpenModalBottomSheet(
    BuildContext context, Transactions item, bool showButtons) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    elevation: 0,
    context: context,
    builder: (context) => MyBottomDetailSheet(
      item: item,
      showButtons: showButtons,
    ),
  );
}

class MyBottomDetailSheet extends StatelessWidget {
  Transactions item;
  bool showButtons;
  MyBottomDetailSheet({required this.item, this.showButtons = true, super.key});

  @override
  Widget build(BuildContext context) {
    final iconList =
        Provider.of<CategoryDataProvider>(context, listen: false).allCategories;
    final DeleteTransaction =
        Provider.of<TransactionDataProvider>(context, listen: false)
            .DeleteTransaction;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      height: screenHeight * 0.56,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              margin: EdgeInsets.only(top: !showButtons ? 15 : 50),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontFamily: font3,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Stack(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "${dateformatter(dateString: item.date)} ${timeformatter(timeString: item.time, context: context)}",
                            style: TextStyle(
                                fontFamily: font2,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "\$${item.amount.toString()}",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: font1,
                                fontWeight: FontWeight.bold,
                                color: item.amount >= 0
                                    ? incomeDark
                                    : expenseDark),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 25),
                    Text(
                      item.description != " "
                          ? item.description
                          : "No Description",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: font2,
                        color: item.description != " "
                            ? const Color.fromARGB(255, 73, 69, 79)
                            : Theme.of(context).secondaryHeaderColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Tooltip(
              message: iconList[item.iconId].name,
              child: Bounceable(
                onTap: () {},
                child: Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(
                    left: 50,
                    right: 20,
                    bottom: 30,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient:
                          LinearGradient(colors: [selectDark, selectLight])),
                  child: Icon(
                    iconList[item.iconId].icon,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              right: 40,
              top: 45,
              child: !showButtons
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyCircularGradientIconButton(
                            size: 40,
                            icon: FluentIcons.edit_32_filled,
                            colorsList: [incomeDark, incomeLight],
                            toolTip: "Edit",
                            onTap: () {
                              editMode = 1;
                              editItem = Transactions(
                                id: item.id,
                                iconId: item.iconId,
                                title: item.title,
                                description: item.description,
                                amount: item.amount,
                                time: item.time,
                                date: item.date,
                              );
                              OpenShowDialog(context);
                            }),
                        const SizedBox(
                          width: 3,
                        ),
                        MyCircularGradientIconButton(
                            size: 40,
                            icon: FluentIcons.delete_32_filled,
                            colorsList: [expenseDark, expenseLight],
                            toolTip: "Delete",
                            onTap: () {
                              OpenAlertDialog(context,
                                  title: "Confirm Delete",
                                  content: " ",
                                  buttonNames: [
                                    "Cancel",
                                    "Delete"
                                  ],
                                  functions: [
                                    () {
                                      Navigator.pop(context);
                                    },
                                    () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      DeleteTransaction(item.id);
                                      Provider.of<CategoryDataProvider>(context,
                                              listen: false)
                                          .RemoveSelection(item.iconId);
                                    },
                                  ]);
                            }),
                      ],
                    )),
        ],
      ),
    );
  }
}
