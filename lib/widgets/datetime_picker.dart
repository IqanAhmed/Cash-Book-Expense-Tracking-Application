import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:cash_book_expense_tracker/utils/variables.dart';
import 'package:flutter/material.dart';

class MyDateTimePicker {
  void presentDatePicker(BuildContext context, Function newStateBuild) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return myTheme(child);
      },
    ).then((date) {
      pickedDate = date.toString();
      newStateBuild();
      return;
    });
  }

  void presentTimePicker(BuildContext context, Function newStateBuild) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return myTheme(child);
      },
    ).then((time) {
      if (time == null) {
        return;
      }
      pickedTime = time.toString();
      newStateBuild();
      return;
    });
  }

  Theme myTheme(Widget? child) {
    return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.light(
            primary: selectDark,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
            outline: const Color.fromARGB(255, 244, 244, 244),
            primaryContainer: selectDark,
            secondaryContainer: selectDark,
            tertiaryContainer: selectDark,
            onPrimaryContainer: Colors.white,
            onSecondaryContainer: Colors.white,
            onTertiaryContainer: Colors.white,
            onSurfaceVariant: Colors.black,
            surfaceContainerHighest: const Color.fromARGB(255, 244, 244, 244),
            surfaceTint: Colors.transparent,
          ),
        ),
        child: child!);
  }
}
