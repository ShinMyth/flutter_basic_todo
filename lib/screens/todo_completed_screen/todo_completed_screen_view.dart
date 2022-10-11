import 'package:todosqflite/models/todo_model.dart';
import 'package:todosqflite/services/sqflite_database_service.dart';
import 'package:todosqflite/widgets/custom_cards.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodoCompletedScreenView extends StatefulWidget {
  const TodoCompletedScreenView({Key? key}) : super(key: key);

  @override
  State<TodoCompletedScreenView> createState() =>
      _TodoCompletedScreenViewState();
}

class _TodoCompletedScreenViewState extends State<TodoCompletedScreenView> {
  List<Todo> listTodoCompleted = <Todo>[];

  @override
  void initState() {
    getTodoCompleted();
    super.initState();
  }

  getTodoCompleted() async {
    // Get all todo with status of completed
    List result =
        await SqfliteDatabaseService().selectTodo(status: "Completed");

    listTodoCompleted.clear();

    setState(
      () {
        for (var value in result) {
          listTodoCompleted.add(
            Todo(
              id: value["id"],
              title: value["title"],
              content: value["content"],
              status: value["status"],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listTodoCompleted.isEmpty
          ? const Center(
              child: Text("TODO(COMPLETED) IS EMPTY"),
            )
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listTodoCompleted.length,
                  itemBuilder: (context, index) {
                    return TodoCompletedCard(
                      todo: listTodoCompleted[index],
                      getTodoCompleted: () => getTodoCompleted(),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
