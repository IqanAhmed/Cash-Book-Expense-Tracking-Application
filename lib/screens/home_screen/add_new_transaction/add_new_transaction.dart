import 'package:cash_book_expense_tracker/provider/transaction_data_provider.dart';
import 'package:cash_book_expense_tracker/utils/date_and_time_formatter.dart';
import 'package:cash_book_expense_tracker/utils/variables.dart';
import 'package:cash_book_expense_tracker/widgets/datetime_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../provider/category_data_provider.dart';
import '../../../utils/themes_data.dart';
import '../../../widgets/gradient_box.dart';
import 'pick_category_bottom_dialog.dart';

// ignore: non_constant_identifier_names
void OpenShowDialog(
  BuildContext context,
) {
  showDialog(
          context: context,
          builder: (BuildContext context) => const MyAddTransactionDialog())
      .then((value) => {});
}

var _titleController = TextEditingController();
var _amountController = TextEditingController();
var _descriptionController = TextEditingController();
var _titleFocus = FocusNode();
var _amountFocus = FocusNode();
var _descriptionFocus = FocusNode();
final _formKey = GlobalKey<FormState>();

Widget DateTimeContainerWidget(
    {required double width,
    required IconData icon,
    required String string,
    required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 247, 247),
          borderRadius: BorderRadius.circular(7)),
      child: Row(children: [
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          string,
          style: const TextStyle(fontSize: 11),
        )
      ]),
    ),
  );
}

class MyAddTransactionDialog extends StatefulWidget {
  const MyAddTransactionDialog({super.key});

  @override
  State<MyAddTransactionDialog> createState() => _MyAddTransactionDialogState();
}

class _MyAddTransactionDialogState extends State<MyAddTransactionDialog> {
  @override
  // void dispose() {
  //   _titleController.dispose();
  //   _amountController.dispose();
  //   _descriptionController.dispose();
  //   super.dispose();
  // }

  void initState() {
    super.initState();
    if (editMode == 1) {
      final categoriesProvider =
          Provider.of<CategoryDataProvider>(context, listen: false);
      _titleController.text = editItem.title;
      _amountController.text = editItem.amount < 0
          ? (editItem.amount * -1).toString()
          : editItem.amount.toString();
      _descriptionController.text = editItem.description == " "
          ? TextEditingController().text
          : editItem.description;
      pickedDate = editItem.date;
      pickedTime = editItem.time;

      categoriesProvider.initializePickCategory(editItem.iconId);
    } else {
      final categoriesProvider =
          Provider.of<CategoryDataProvider>(context, listen: false);
      categoriesProvider.initializePickCategory(0);
      _titleController = TextEditingController();
      _amountController = TextEditingController();
      _descriptionController = TextEditingController();
      pickedDate = DateTime.now().toString();
      pickedTime = DateTime.now().toString();
    }
  }

  void newStateFun() {
    setState(() {});
  }

  void addNewTransactionFun({required bool isIncome}) {
    final categoriesProvider =
        Provider.of<CategoryDataProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionDataProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      if (_descriptionController.text.isEmpty) {
        _descriptionController.text = " ";
      }
      Navigator.pop(context);
      transactionProvider.AddNewTransaction(
          title: _titleController.text,
          categoryId: categoriesProvider.selectedPickCategory,
          amount: num.parse(_amountController.text),
          description: _descriptionController.text,
          inputTime: pickedTime,
          inputDate: pickedDate,
          isIncome: isIncome);
    }
  }

  void updateTransactionFun({required bool isIncome}) {
    final categoriesProvider =
        Provider.of<CategoryDataProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionDataProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      if (_descriptionController.text.isEmpty) {
        _descriptionController.text = " ";
      }
      Navigator.pop(context);
      Navigator.pop(context);
      transactionProvider.UpdateTransaction(
          id: editItem.id,
          title: _titleController.text,
          categoryId: categoriesProvider.selectedPickCategory,
          amount: num.parse(_amountController.text),
          description: _descriptionController.text,
          inputTime: pickedTime,
          inputDate: pickedDate,
          isIncome: isIncome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoryDataProvider>(context, listen: true);
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: screenWidth >= 300
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DateTimeContainerWidget(
                              width: 90,
                              icon: FluentIcons.clock_24_regular,
                              string: timeformatter(
                                timeString: pickedTime,
                                context: context,
                              ),
                              onTap: () {
                                MyDateTimePicker obj = MyDateTimePicker();
                                obj.presentTimePicker(context, newStateFun);
                              },
                            ),
                            DateTimeContainerWidget(
                              width: 110,
                              icon: FluentIcons.calendar_24_regular,
                              string: dateformatter(
                                dateString: pickedDate,
                              ),
                              onTap: () {
                                MyDateTimePicker obj = MyDateTimePicker();
                                obj.presentDatePicker(context, newStateFun);
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: DateTimeContainerWidget(
                                width: 90,
                                icon: FluentIcons.clock_24_regular,
                                string: "15:00 AM",
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: DateTimeContainerWidget(
                                width: 110,
                                icon: FluentIcons.calendar_24_regular,
                                string: "Feb 21, 2024",
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                    bottom: 5,
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocus,
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(
                            color: iconColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: font1),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: selectDark, width: 2))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Title Required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (screenWidth * 0.6) - 80,
                        // height: 50,
                        margin: const EdgeInsets.only(bottom: 15, top: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          controller: _amountController,
                          focusNode: _amountFocus,
                          decoration: InputDecoration(
                            labelText: "Amount",
                            labelStyle: TextStyle(
                                color: iconColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: font1),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: selectDark, width: 2)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Amount Required';
                            } else if (double.tryParse(value) == null) {
                              return 'Invalid Amount';
                            }
                            return null;
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _titleFocus.unfocus();
                            _amountFocus.unfocus();
                            _descriptionFocus.unfocus();
                            OpenModalBottomSheet2(context);
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 9),
                              // color: Colors.green,
                              width: (screenWidth * 0.4) - 40,
                              height: 80,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // right: 15,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 0),
                                      width: (screenWidth * 0.3),
                                      height: 63.6,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.2, color: fieldColor),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          screenWidth > 265
                                              ? SizedBox(
                                                  width: screenWidth * 0.2 - 15,
                                                  height: 22,
                                                  child: Center(
                                                      child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(categoriesProvider
                                                                      .allCategories[
                                                                          categoriesProvider
                                                                              .selectedPickCategory]
                                                                      .id ==
                                                                  0
                                                              ? "Misc"
                                                              : categoriesProvider
                                                                  .allCategories[
                                                                      categoriesProvider
                                                                          .selectedPickCategory]
                                                                  .name))))
                                              : const SizedBox(),
                                          screenWidth > 265
                                              ? Container(
                                                  width: 1,
                                                  height: 30,
                                                  color: fieldColor,
                                                )
                                              : const SizedBox(),
                                          Icon(
                                            categoriesProvider
                                                .allCategories[
                                                    categoriesProvider
                                                        .selectedPickCategory]
                                                .icon,
                                            color: iconColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 2,
                                left: 9,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 3, right: 5),
                                  color: Colors.white,
                                  child: screenWidth > 280
                                      ? Text("Category",
                                          style: TextStyle(
                                            color: iconColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: font1,
                                            fontSize: 11.4,
                                          ))
                                      : Text(
                                          "Type",
                                          style: TextStyle(
                                            color: iconColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: font1,
                                            fontSize: 11.5,
                                          ),
                                        ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 5,
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    focusNode: _descriptionFocus,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(
                          color: iconColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: font1),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: selectDark, width: 2)),
                    ),
                    validator: (value) {
                      // if (value!.isEmpty) {
                      //   _descriptionController.text = " ";
                      // }
                      return null;
                    },
                  ),
                ),
                //
                //
                //
                //
                //
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth <= 275
                          ? screenWidth * 0.27
                          : screenWidth * 0.3,
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: GradientBox(
                          amountEnable: false,
                          amount: 0,
                          title: "Cash In",
                          gradient1: incomeDark,
                          gradient2: incomeLight,
                          openDetail: () {
                            editMode == 1
                                ? updateTransactionFun(isIncome: true)
                                : addNewTransactionFun(isIncome: true);
                          }),
                    ),
                    Container(
                      width: screenWidth <= 275
                          ? screenWidth * 0.27
                          : screenWidth * 0.3,
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: GradientBox(
                          amountEnable: false,
                          amount: 0,
                          title: "Cash Out",
                          gradient1: expenseDark,
                          gradient2: expenseLight,
                          openDetail: () {
                            editMode == 1
                                ? updateTransactionFun(isIncome: false)
                                : addNewTransactionFun(isIncome: false);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
