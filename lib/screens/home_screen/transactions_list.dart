import 'package:cash_book_expense_tracker/provider/category_data_provider.dart';
import 'package:cash_book_expense_tracker/utils/date_and_time_formatter.dart';
import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:cash_book_expense_tracker/widgets/bottom_detail_sheet.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/transaction_data_provider.dart';

class MyTransactionsList extends StatelessWidget {
  const MyTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final allCategories =
        Provider.of<CategoryDataProvider>(context, listen: false).allCategories;

    return Consumer2<CategoryDataProvider, TransactionDataProvider>(
        builder: (context, categoryData, transactionData, child) {
      final itemsList = transactionData.fullList
          .where((element) =>
              categoryData.allSelectedCategories.isEmpty ||
              categoryData.allSelectedCategories.contains(element.iconId))
          .toList()
          .reversed
          .toList();
      if (itemsList.isEmpty) {
        return const Center(
          child: Text(
            "No Transaction",
            style: TextStyle(color: Colors.grey),
          ),
        );
      } else {
        return ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 80),
          itemCount: itemsList.length,
          itemBuilder: (BuildContext context, int index) {
            {
              return DelayedDisplay(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  child: ListTile(
                    onTap: () {
                      OpenModalBottomSheet(context, itemsList[index], true);
                    },
                    horizontalTitleGap: 25,
                    leading: Tooltip(
                        message: allCategories[itemsList[index].iconId].name,
                        child:
                            Icon(allCategories[itemsList[index].iconId].icon)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemsList[index].title,
                          style: const TextStyle(
                              fontFamily: font2,
                              letterSpacing: 1,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${dateformatter(dateString: itemsList[index].date)} ${timeformatter(timeString: itemsList[index].time, context: context)}",
                          style: TextStyle(
                              fontFamily: font2,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "\$${itemsList[index].amount.toString()}",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: font1,
                          fontWeight: FontWeight.bold,
                          color: itemsList[index].amount >= 0
                              ? incomeDark
                              : expenseDark),
                    ),
                  ),
                ),
              );
            }
          },
          separatorBuilder: (context, index) {
            return DelayedDisplay(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Divider()),
            );
          },
        );
      }
    });
  }
}
