import 'package:todosqflite/models/todo_model.dart';
import 'package:todosqflite/shared/shared_dialog.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  showSharedDialogUpdate() {
    ScrollController scrollController = ScrollController();

    showSharedDialog(
      context: context,
      barrierDismissible: true,
      title: const Text("Todo Details"),
      content: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.5.h),
            const TextField(
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                label: Text("Title"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Scrollbar(
              controller: scrollController,
              isAlwaysShown: true,
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.multiline,
                minLines: 8,
                maxLines: 8,
                scrollController: scrollController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  label: Text("Content"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actionFunction1: () {
        Navigator.pop(context);
      },
      actionLabel1: const Text("Cancel"),
      actionFunction2: () {
        Navigator.pop(context);
      },
      actionLabel2: const Text("Update"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 1.h),
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Colors.green.withOpacity(0.9),
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'Completed',
            ),
          ],
        ),
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
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showSharedDialogUpdate();
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Update',
            ),
            const SlidableAction(
              onPressed: null,
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
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
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Colors.orange.withOpacity(0.9),
              foregroundColor: Colors.white,
              icon: Icons.close,
              label: 'Pending',
            ),
          ],
        ),
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
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
