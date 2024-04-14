// ignore_for_file: depend_on_referenced_packages

import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Category {
  work,
  travel,
  leisure,
  food,
}

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
};

class Expense {
  Expense({
    required this.date,
    required this.amount,
    required this.title,
    required this.category,
  }) : id = const Uuid().v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (var element in expenses) {
      sum = sum + element.amount;
    }

    return sum;
  }
}
