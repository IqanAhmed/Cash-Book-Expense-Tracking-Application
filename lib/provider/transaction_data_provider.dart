// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../database/databasehelper.dart';
import 'models/transaction_model.dart';

class TransactionDataProvider with ChangeNotifier {
  List<Transactions> _myTransactionsList = [];

  List<Transactions> get fullList => _myTransactionsList;

  List<Transactions>? get incomeList =>
      _myTransactionsList.where((element) => element.amount >= 0).toList();

  List<Transactions>? get expenseList =>
      _myTransactionsList.where((element) => element.amount < 0).toList();

  Future<void> initializeDatabase() async {
    try {
      _myTransactionsList = [];
      List<Transactions> tempList = await DatabaseHelper.instance.getData();
      for (int i = 0; i < tempList.length; i++) {
        _myTransactionsList.add(tempList[i]);
      }
    } catch (e) {
      // ignore: avoid_print
    }
  }

  num CurrentBalance() {
    num sum = 0;
    for (int i = 0; i < _myTransactionsList.length; i++) {
      sum = sum + _myTransactionsList[i].amount;
    }
    return sum;
  }

  num TotalIncome() {
    num sum = 0;
    for (int i = 0; i < _myTransactionsList.length; i++) {
      if (_myTransactionsList[i].amount >= 0) {
        sum = sum + _myTransactionsList[i].amount;
      }
    }
    return sum;
  }

  num TotalExpense() {
    num sum = 0;
    for (int i = 0; i < _myTransactionsList.length; i++) {
      if (_myTransactionsList[i].amount < 0) {
        sum = sum + _myTransactionsList[i].amount;
      }
    }
    return sum * -1;
  }

  void DeleteTransaction(String id) {
    _myTransactionsList.removeWhere((element) => element.id == id);
    DatabaseHelper.instance.deleteFromDatabase(id);
    print(id);
    CurrentBalance();
    TotalExpense();
    TotalIncome();
    notifyListeners();
  }

  void AddNewTransaction(
      {required String title,
      required int categoryId,
      required String description,
      required num amount,
      required String inputTime,
      required String inputDate,
      required isIncome}) {
    if (isIncome == false) {
      Transactions obj = Transactions(
        id: const Uuid().v4().toString(),
        iconId: categoryId,
        title: title,
        description: description,
        amount: amount * -1,
        time: inputTime,
        date: inputDate,
      );
      _myTransactionsList.add(obj);
      DatabaseHelper.instance.addIntoDatabase(obj);
    } else {
      Transactions obj = Transactions(
        id: const Uuid().v4().toString(),
        iconId: categoryId,
        title: title,
        description: description,
        amount: amount,
        time: inputTime,
        date: inputDate,
      );
      _myTransactionsList.add(obj);
      DatabaseHelper.instance.addIntoDatabase(obj);
    }
    notifyListeners();
  }

  void UpdateTransaction(
      {required String id,
      required String title,
      required int categoryId,
      required String description,
      required num amount,
      required String inputTime,
      required String inputDate,
      required isIncome}) {
    if (isIncome == false) {
      Transactions obj = Transactions(
        id: id,
        iconId: categoryId,
        title: title,
        description: description,
        amount: amount * -1,
        time: inputTime,
        date: inputDate,
      );
      int ind =
          _myTransactionsList.indexWhere((element) => element.id == obj.id);
      _myTransactionsList[ind] = obj;
      DatabaseHelper.instance.updateDatabase(obj.id, obj);
    } else {
      Transactions obj = Transactions(
        id: id,
        iconId: categoryId,
        title: title,
        description: description,
        amount: amount,
        time: inputTime,
        date: inputDate,
      );
      int ind =
          _myTransactionsList.indexWhere((element) => element.id == obj.id);
      _myTransactionsList[ind] = obj;
      DatabaseHelper.instance.updateDatabase(obj.id, obj);
    }
    notifyListeners();
  }

  // Analysis Page
  List<String> dataDates = [];
  void makeCalendarData() {}
}
