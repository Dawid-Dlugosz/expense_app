import 'package:expense_app/widgets/chart/chart.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/new_expense.dart';
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

  void _addNewExpense(Expense expense) {
    setState(() {
      _list.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _list.indexOf(expense);
    setState(() {
      _list.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense delete'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _list.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverley() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addNewExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _list),
                Expanded(
                  child: ExpensesList(
                    onDismissed: _removeExpense,
                    expanses: _list,
                  ),
                )
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _list,
                  ),
                ),
                Expanded(
                  child: ExpensesList(
                    onDismissed: _removeExpense,
                    expanses: _list,
                  ),
                )
              ],
            ),
    );
  }
}
