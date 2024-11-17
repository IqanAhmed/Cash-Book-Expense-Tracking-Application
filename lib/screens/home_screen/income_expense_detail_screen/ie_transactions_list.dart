// ignore_for_file: must_be_immutable
import 'package:cash_book_expense_tracker/provider/category_data_provider.dart';
import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/transaction_data_provider.dart';
import '../../../widgets/bottom_detail_sheet.dart';

class MyIETransactionsList extends StatefulWidget {
  String screen;
  MyIETransactionsList({required this.screen, super.key});

  @override
  State<MyIETransactionsList> createState() => _MyIETransactionsListState();
}

class _MyIETransactionsListState extends State<MyIETransactionsList> {
  @override
  Widget build(BuildContext context) {
    final allCategories = Provider.of<CategoryDataProvider>(
      context,
    ).allCategories;
    final routeName = ModalRoute.of(context)!.settings.name;

    return Consumer<CategoryDataProvider>(
      builder: (context, categoryData, child) {
        final itemsList = routeName == routeIEScreen &&
                widget.screen == "Income"
            ? Provider.of<TransactionDataProvider>(context, listen: true)
                .incomeList
                ?.reversed
                .toList()
            : routeName == routeIEScreen && widget.screen == "Expense"
                ? Provider.of<TransactionDataProvider>(context, listen: true)
                    .expenseList
                    ?.reversed
                    .toList()
                : Provider.of<TransactionDataProvider>(context, listen: true)
                    .fullList
                    .where((element) =>
                        categoryData.allSelectedCategories.isEmpty ||
                        categoryData.allSelectedCategories
                            .contains(element.iconId))
                    .toList()
                    .reversed
                    .toList();

        return ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 15),
          itemCount: itemsList!.length,
          itemBuilder: (BuildContext context, int index) {
            return DelayedDisplay(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: ListTile(
                  onTap: () {
                    OpenModalBottomSheet(context, itemsList[index], false);
                  },
                  horizontalTitleGap: 25,
                  leading: Tooltip(
                      message: allCategories[itemsList[index].iconId].name,
                      child: Icon(allCategories[itemsList[index].iconId].icon)),
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
                        itemsList[index].date,
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
          },
          separatorBuilder: (context, index) {
            return DelayedDisplay(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Divider()),
            );
          },
        );
      },
    );
  }
}
