import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../provider/models/transaction_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cash_book.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE TRANSACTIONS (
        ID TEXT UNIQUE NOT NULL,
        IconID INTEGER NOT NULL,
        Title TEXT NOT NULL,
        Description TEXT,
        Amount NUMERIC,
        Time STRING,
        Date STRING
      )
    ''',
    );

    //  await db.execute(
    //     '''
    //     CREATE TABLE LOGS (
    //       LogID INTEGER PRIMARY KEY AUTOINCREMENT,
    //       TransactionID TEXT NOT NULL,
    //       IconID TEXT,
    //       Title TEXT,
    //       Description TEXT,
    //       Amount TEXT,
    //       Time TEXT,
    //       Date TEXT,
    //       isIconID int,
    //       isTitle int,
    //       isDescription int,
    //       isAmount int,
    //       isTime int,
    //       isDate int,
    //     )
    //   ''',
    //   );
  }

  Future<List<Transactions>> getData() async {
    Database db = await instance.database;
    var item = await db.query('TRANSACTIONS');
    List<Transactions> itemList = item.isNotEmpty
        ? item.map((c) => Transactions.fromMap(c)).toList()
        : [];
    return itemList;
  }

  //   Future<List<Logs>> getLogs() async {
  //   Database db = await instance.database;
  //   var item = await db.query('Logs');
  //   List<Logs> itemList = item.isNotEmpty
  //       ? item.map((c) => Logs.fromMap(c)).toList()
  //       : [];
  //   return itemList;
  // }

  Future<int> addIntoDatabase(Transactions item) async {
    Database db = await instance.database;
    return await db.insert('TRANSACTIONS', item.toMap());
  }

  Future<int> deleteFromDatabase(String id) async {
    Database db = await instance.database;

    return await db.delete(
      'TRANSACTIONS',
      where: 'ID = ? ',
      whereArgs: [
        id,
      ],
    );
  }

  Future<int> updateDatabase(String itemId, Transactions updateItem) async {
    Database db = await instance.database;
    return await db.update('TRANSACTIONS', updateItem.toMap(),
        where: "ID = ?", whereArgs: [itemId]);
  }
}
