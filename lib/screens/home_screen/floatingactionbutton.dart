import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../../utils/variables.dart';
import 'add_new_transaction/add_new_transaction.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(38)),
      backgroundColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      splashColor: Colors.transparent,
      elevation: 2,
      disabledElevation: 0,
      hoverElevation: 1.5,
      highlightElevation: 0,
      focusElevation: 0,
      enableFeedback: false,
      onPressed: () {
        editMode = 0;
        // editItem = Transactions(id: id, iconId: iconId, title: title, description: description, amount: amount, time: time, date: date, location: location)
        OpenShowDialog(context);
      },
      child: Ink(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              selectDark,
              selectLight,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: const Icon(
          FluentIcons.add_32_regular,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
