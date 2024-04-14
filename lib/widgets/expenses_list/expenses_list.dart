import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expanses,
    required this.onDismissed,
    super.key,
  });

  final List<Expense> expanses;
  final Function(Expense expense) onDismissed;
  @override
  Widget build(BuildContext context) {
    return expanses.isNotEmpty
        ? ListView.builder(
            itemCount: expanses.length,
            itemBuilder: (context, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withAlpha(100),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              key: ValueKey(expanses[index]),
              onDismissed: (_) => onDismissed(expanses[index]),
              child: ExpensesItem(
                expanses[index],
              ),
            ),
          )
        : const Center(
            child: Text('No expenses. Add somethig.'),
          );
  }
}
