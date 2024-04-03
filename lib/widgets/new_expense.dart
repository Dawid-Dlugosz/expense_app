import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});

  final Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectDate;
  Category _selectCategory = Category.leisure;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectDate = pickedDate;
    });
  }

  void _submitExpenseForm() {
    final enteredAmmount = double.tryParse(_amountController.text);
    final isAmountIsInvalid = enteredAmmount == null || enteredAmmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountIsInvalid ||
        _selectDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text('Check entered data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
      return;
    }
    widget.addExpense(
      Expense(
        date: _selectDate!,
        amount: enteredAmmount,
        title: _titleController.text,
        category: _selectCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefix: Text('\$ '),
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectDate == null
                          ? 'No date selected'
                          : formatter.format(_selectDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: DropdownButton(
                  value: _selectCategory,
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectCategory = value!;
                    });
                  },
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseForm,
                child: const Text('Save Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
