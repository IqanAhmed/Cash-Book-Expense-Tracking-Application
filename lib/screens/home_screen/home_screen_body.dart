// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../widgets/appbar.dart';
import 'current_balance.dart';
import 'floatingactionbutton.dart';
import 'income_expenses.dart';
import 'select_filter.dart';
import 'transactions_list.dart';

class MyHomeScreenBody extends StatefulWidget {
  const MyHomeScreenBody({super.key});

  @override
  State<MyHomeScreenBody> createState() => _MyHomeScreenBodyState();
}

class _MyHomeScreenBodyState extends State<MyHomeScreenBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void OpenDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: MyAppBar(OpenDrawer, "CASH BOOK")),
      body: const SafeArea(
        child: Column(children: [
          Flexible(flex: 6, child: MyCurrentBalance()),
          MyIncomeExpenses(),
          MySelectType(),
          Flexible(flex: 18, child: MyTransactionsList()),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: const MyFloatingActionButton(),
    );
  }
}
