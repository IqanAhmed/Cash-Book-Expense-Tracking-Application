// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

import '../utils/themes_data.dart';

class MyAppBar extends StatelessWidget {
  var openDrawer;
  String title;
  MyAppBar(this.openDrawer, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: font1,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 7,
            color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
