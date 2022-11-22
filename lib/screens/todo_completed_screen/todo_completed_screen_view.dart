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

  // Get all todo's with status of completed
  void getTodoCompleted() async {
    List result =
        await SqfliteDatabaseService().selectTodo(status: "Completed");

    setState(
      () {
        listTodoCompleted.clear();

        for (var value in result) {
          listTodoCompleted.add(Todo.fromMap(value));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listTodoCompleted.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 27.sp,
                    color: Colors.black45,
                  ),
                  SizedBox(height: 1.25.h),
                  Text(
                    "You have no completed todo's yet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
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
    );
  }
}
