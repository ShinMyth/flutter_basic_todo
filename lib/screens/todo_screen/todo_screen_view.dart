import 'package:todosqflite/screens/todo_completed_screen/todo_completed_screen_view.dart';
import 'package:todosqflite/screens/todo_pending_screen/todo_pending_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodoScreenView extends StatefulWidget {
  const TodoScreenView({Key? key}) : super(key: key);

  @override
  State<TodoScreenView> createState() => _TodoScreenViewState();
}

class _TodoScreenViewState extends State<TodoScreenView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Todo Sqflite"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16.sp),
            tabs: const [
              Tab(text: "PENDING"),
              Tab(text: "COMPLETED"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TodoPendingScreenView(),
            TodoCompletedScreenView(),
          ],
        ),
      ),
    );
  }
}
