import 'package:todosqflite/widgets/custom_cards.dart';
import 'package:todosqflite/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoCompletedScreenView extends StatefulWidget {
  const TodoCompletedScreenView({Key? key}) : super(key: key);

  @override
  State<TodoCompletedScreenView> createState() =>
      _TodoCompletedScreenViewState();
}

class _TodoCompletedScreenViewState extends State<TodoCompletedScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TodoCompletedCard(
            todo: Todo(title: "Todo #4"),
          ),
        ],
      ),
    );
  }
}
