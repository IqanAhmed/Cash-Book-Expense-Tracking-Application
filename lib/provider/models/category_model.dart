// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AvailableCategories {
  Miscellaneous,
  Housing,
  Transportation,
  Food,
  Health,
  Entertainment,
  Utilities,
  Shopping,
  Payment,
  Savings,
  Loan,
  Taxes,
}

class Categories {
  int id;
  String name;
  IconData icon;
  Categories(this.id, this.name, this.icon);
}
