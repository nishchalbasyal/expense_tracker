import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) =>  NewExpense(onAddExpense: _addExpense,),
    );
  }

  void _addExpense(Expense expense){
    setState((){
         
          _registerdExpenses.add(expense);
    });
  }


void _removedExpense(Expense expense){
  final expenseIndex = _registerdExpenses.indexOf(expense);
      setState(() {
        _registerdExpenses.remove(expense);
      });

      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(duration: const Duration(seconds: 3),content: const Text('Expense Deleted.'),
         action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _registerdExpenses.insert(expenseIndex, expense);
          });
         }),)
      );
    }
  @override
  Widget build(BuildContext context) {

    Widget mainContent  = Center(child: Text('No Expenses found. Start adding some!'));

    if (_registerdExpenses.isNotEmpty){
      mainContent =            ExpensesList(expenses: _registerdExpenses,
           onRemoveExpense: _removedExpense,);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('Chart'),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
