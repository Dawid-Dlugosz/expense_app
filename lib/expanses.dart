import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expneses extends StatefulWidget {
  const Expneses({super.key});

  @override
  State<Expneses> createState() => _ExpnesesState();
}

class _ExpnesesState extends State<Expneses> {
  final List<Expense> _list = [
    Expense(
      date: DateTime.now(),
      amount: 2.99,
      title: 'title 1',
      category: Category.food,
    ),
    Expense(
      date: DateTime.now(),
      amount: 3.99,
      title: 'title 2',
      category: Category.work,
    ),
    Expense(
      date: DateTime.now(),
      amount: 4.99,
      title: 'title 3',
      category: Category.travel,
    ),
    Expense(
      date: DateTime.now(),
      amount: 5.99,
      title: 'title 4',
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverley() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const Text('Modal bottom Sheet'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense app tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverley,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('the cart,'),
          Expanded(
            child: ExpensesList(
              expanses: _list,
            ),
          )
        ],
      ),
    );
  }
}
