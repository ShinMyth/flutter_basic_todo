import 'package:todosqflite/widgets/custom_cards.dart';
import 'package:todosqflite/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoPendingScreenView extends StatefulWidget {
  const TodoPendingScreenView({Key? key}) : super(key: key);

  @override
  State<TodoPendingScreenView> createState() => _TodoPendingScreenViewState();
}

class _TodoPendingScreenViewState extends State<TodoPendingScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TodoPendingCard(
            todo: Todo(title: "Todo #1"),
          ),
          TodoPendingCard(
            todo: Todo(title: "Todo #2"),
          ),
          TodoPendingCard(
            todo: Todo(title: "Todo #3"),
          ),
          TodoPendingCard(
            todo: Todo(title: "Todo #5"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
