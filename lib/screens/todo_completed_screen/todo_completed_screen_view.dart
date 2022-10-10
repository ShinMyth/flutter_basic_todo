import 'package:todosqflite/models/todo_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TodoCompletedCard(
                todo: Todo(
                  title: "Todo #4",
                  content:
                      "qweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\nqweqe\n",
                ),
              ),
              TodoCompletedCard(
                todo: Todo(
                  title: "Todo #5",
                  content: "qweqe\nqweqe\nqweqe\nqweqe\nqweqe\n",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
