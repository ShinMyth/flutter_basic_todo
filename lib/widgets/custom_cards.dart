import 'package:todosqflite/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Used in todo pending screen
class TodoPendingCard extends StatefulWidget {
  const TodoPendingCard({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  State<TodoPendingCard> createState() => _TodoPendingCardState();
}

class _TodoPendingCardState extends State<TodoPendingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 1.h,
        left: 2.w,
        right: 2.w,
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: ListTile(
          leading: Icon(
            Icons.assignment,
            size: 21.sp,
          ),
          title: Text(widget.todo.title),
          trailing: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.expand_more,
            ),
          ),
        ),
      ),
    );
  }
}

// Used in todo completed screen
class TodoCompletedCard extends StatefulWidget {
  const TodoCompletedCard({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  State<TodoCompletedCard> createState() => _TodoCompletedCardState();
}

class _TodoCompletedCardState extends State<TodoCompletedCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 1.h,
        left: 2.w,
        right: 2.w,
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: ListTile(
          leading: Icon(
            Icons.assignment_turned_in,
            size: 21.sp,
          ),
          title: Text(widget.todo.title),
          trailing: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.expand_more,
            ),
          ),
        ),
      ),
    );
  }
}
