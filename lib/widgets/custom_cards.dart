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
  bool isExpanded = false;
  ScrollController scrollController = ScrollController();

  changeIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 1.h),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.assignment,
                size: 21.sp,
              ),
              title: Text(widget.todo.title),
              trailing: GestureDetector(
                onTap: () {
                  changeIsExpanded();
                },
                child: Icon(
                  isExpanded == false ? Icons.expand_more : Icons.expand_less,
                ),
              ),
            ),
            if (isExpanded == true) ...[
              const Divider(),
              Container(
                height: 18.5.h,
                width: 85.w,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Scrollbar(
                  controller: scrollController,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: Text(
                      widget.todo.content,
                      style: TextStyle(
                        fontSize: 15.5.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
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
  bool isExpanded = false;
  ScrollController scrollController = ScrollController();

  changeIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 1.h),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.assignment_turned_in,
                size: 21.sp,
              ),
              title: Text(widget.todo.title),
              trailing: GestureDetector(
                onTap: () {
                  changeIsExpanded();
                },
                child: Icon(
                  isExpanded == false ? Icons.expand_more : Icons.expand_less,
                ),
              ),
            ),
            if (isExpanded == true) ...[
              const Divider(),
              Container(
                height: 18.5.h,
                width: 85.w,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Scrollbar(
                  controller: scrollController,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: Text(
                      widget.todo.content,
                      style: TextStyle(
                        fontSize: 15.5.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
