// ignore_for_file: non_constant_identifier_names

import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:cash_book_expense_tracker/provider/transaction_data_provider.dart';
import 'package:cash_book_expense_tracker/widgets/custom_title.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import '../../provider/category_data_provider.dart';
import '../../provider/models/transaction_model.dart';

class MySelectType extends StatefulWidget {
  const MySelectType({super.key});

  @override
  State<MySelectType> createState() => _MySelectTypeState();
}

class _MySelectTypeState extends State<MySelectType> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    List<int> categoriesToShowFun(BuildContext context) {
      List<Transactions> fullList =
          Provider.of<TransactionDataProvider>(context).fullList;
      return fullList.map((transaction) => transaction.iconId).toSet().toList()
        ..sort();
    }

    final categoriesToShow = categoriesToShowFun(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final allCategories =
        Provider.of<CategoryDataProvider>(context, listen: false).allCategories;

    final Toggleselection =
        Provider.of<CategoryDataProvider>(context, listen: false)
            .Toggleselection;
    final ResetCategories =
        Provider.of<CategoryDataProvider>(context, listen: false)
            .ResetCategories;
    final allSelectedCategories =
        Provider.of<CategoryDataProvider>(context, listen: false)
            .allSelectedCategories;
    return Consumer2<TransactionDataProvider, CategoryDataProvider>(
        builder: (context, transactionData, categoryData, child) =>
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: show ? 95 : 40,
              margin: EdgeInsets.only(top: screenHeight * 0.03),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.08,
                        right: screenWidth * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          screenWidth > 155
                              ? CustomTitle(title: "Transactions")
                              : const SizedBox(),
                          Tooltip(
                            message: "Filter",
                            child: IconButton(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  show = !show;
                                  if (show == false) {
                                    ResetCategories();
                                  }
                                });
                              },
                              icon: Bounceable(
                                onTap: null,
                                child: Icon(show
                                    ? Icons.close
                                    : FluentIcons.filter_12_regular),
                              ),
                              style: const ButtonStyle(
                                  iconSize: WidgetStatePropertyAll(20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (show)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            for (int i = 0; i < categoriesToShow.length; i++)
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 200),
                                slidingBeginOffset: Offset((i + 1) * 1, 0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: allSelectedCategories
                                            .contains(categoriesToShow[i])
                                        ? selectDim
                                        : Colors.white,
                                    border: Border.all(
                                      width: allSelectedCategories
                                              .contains(categoriesToShow[i])
                                          ? 1
                                          : 1,
                                      color: allSelectedCategories
                                              .contains(categoriesToShow[i])
                                          ? selectDark
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Toggleselection(
                                            allCategories[categoriesToShow[i]]
                                                .id);
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Ink(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Text(
                                          allCategories[categoriesToShow[i]]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            fontSize: 11,
                                            fontFamily: font1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ));
  }
}
