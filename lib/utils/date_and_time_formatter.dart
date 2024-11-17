import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateformatter({
  required var dateString,
}) {
  try {
    dateString = dateString.toString();
    DateTime dateTime = DateTime.parse(dateString);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  } catch (e) {
    return DateFormat('MMM dd, yyyy').format(DateTime.now());
  }
}

String timeformatter({
  required var timeString,
  required BuildContext context,
}) {
  timeString = timeString.toString();
  // Check if the input is in "2024-05-19 06:23:20.155108" format
  if (timeString.contains("-")) {
    DateTime dateTime = DateTime.parse(timeString);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }
  // Check if the input is in "TimeOfDay(06:23)" format
  else if (timeString.contains("TimeOfDay")) {
    // Extract hour and minute from the input
    timeString = timeString.substring(10, timeString.length - 1);
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Create TimeOfDay object
    TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);

    // Format TimeOfDay to the desired format
    String formattedTime = MaterialLocalizations.of(context)
        .formatTimeOfDay(timeOfDay, alwaysUse24HourFormat: false);

    // Return the formatted time
    return formattedTime;
  }
  // Return empty string if the input format is not recognized
  else {
    return DateFormat('hh:mm a').format(DateTime.now());
  }
}
