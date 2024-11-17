import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

void OpenAlertDialog(
  BuildContext context, {
  String title = "null",
  required String content,
  required List<String> buttonNames,
  required List<void Function()?> functions,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialog(
          title: title,
          content: content,
          buttonNames: buttonNames,
          functions: functions,
        );
      });
}

// ignore: must_be_immutable
class MyAlertDialog extends StatelessWidget {
  String title;
  String content;
  List<String> buttonNames;
  List<void Function()?> functions;
  MyAlertDialog(
      {this.title = "null",
      required this.content,
      required this.buttonNames,
      required this.functions,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        surfaceTintColor: Colors.transparent,
        title: title == "null"
            ? null
            : Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Color.fromARGB(255, 73, 69, 79),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: font2),
              ),
        icon: Icon(
          FluentIcons.warning_12_regular,
          size: 40,
          color: expenseDark2,
        ),
        content: const Text(
          'Are you sure you want to delete?',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: font2),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: functions[0],
            child: Text(buttonNames[0]),
          ),
          TextButton(
            onPressed: functions[1],
            child: Text(buttonNames[1]),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceEvenly);
  }
}
