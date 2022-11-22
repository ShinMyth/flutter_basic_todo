import 'package:todosqflite/models/todo_model.dart';
import 'package:todosqflite/services/sqflite_database_service.dart';
import 'package:todosqflite/shared/shared_dialog.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Used in todo_pending_screen
class TodoPendingCard extends StatefulWidget {
  const TodoPendingCard({
    Key? key,
    required this.todo,
    required this.getTodoPending,
  }) : super(key: key);

  final Todo todo;
  final Function() getTodoPending;

  @override
  State<TodoPendingCard> createState() => _TodoPendingCardState();
}

class _TodoPendingCardState extends State<TodoPendingCard> {
  bool isExpanded = false;
  ScrollController scrollController = ScrollController();

  void changeIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void showSharedDialogTodoUpdate() {
    ScrollController scrollController = ScrollController();
    TextEditingController titleController = TextEditingController()
      ..text = widget.todo.title;
    TextEditingController contentController = TextEditingController()
      ..text = widget.todo.content;

    showSharedDialog(
      context: context,
      barrierDismissible: false,
      title: const Text("Todo Details"),
      content: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 2.5.h),
            TextField(
              controller: titleController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text("Title"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Scrollbar(
              controller: scrollController,
              isAlwaysShown: true,
              child: TextField(
                controller: contentController,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.multiline,
                minLines: 8,
                maxLines: 8,
                scrollController: scrollController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  label: Text("Content"),
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
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
      actionFunction2: () async {
        FocusManager.instance.primaryFocus!.unfocus();

        if (titleController.text.isNotEmpty &&
            contentController.text.isNotEmpty) {
          await SqfliteDatabaseService().updateTodo(
            id: widget.todo.id,
            title: titleController.text,
            content: contentController.text,
            status: widget.todo.status,
          );

          widget.getTodoPending();

          Navigator.pop(context);
        }
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
              onPressed: (context) async {
                await SqfliteDatabaseService().updateTodo(
                  id: widget.todo.id,
                  title: widget.todo.title,
                  content: widget.todo.content,
                  status: "Completed",
                );

                widget.getTodoPending();
              },
              backgroundColor: Colors.green.withOpacity(0.9),
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: "Completed",
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.assignment_outlined,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                  child: Scrollbar(
                    controller: scrollController,
                    isAlwaysShown: true,
                    child: TextField(
                      controller: TextEditingController()
                        ..text = widget.todo.content,
                      minLines: 8,
                      maxLines: 8,
                      scrollController: scrollController,
                      readOnly: true,
                      enableInteractiveSelection: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
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
                showSharedDialogTodoUpdate();
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: "Update",
            ),
            SlidableAction(
              onPressed: (context) async {
                await SqfliteDatabaseService().deleteTodo(
                  id: widget.todo.id,
                );

                widget.getTodoPending();
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Delete",
            ),
          ],
        ),
      ),
    );
  }
}

// Used in todo_completed_screen
class TodoCompletedCard extends StatefulWidget {
  const TodoCompletedCard({
    Key? key,
    required this.todo,
    required this.getTodoCompleted,
  }) : super(key: key);

  final Todo todo;
  final Function() getTodoCompleted;

  @override
  State<TodoCompletedCard> createState() => _TodoCompletedCardState();
}

class _TodoCompletedCardState extends State<TodoCompletedCard> {
  bool isExpanded = false;
  ScrollController scrollController = ScrollController();

  void changeIsExpanded() {
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
              onPressed: (context) async {
                await SqfliteDatabaseService().updateTodo(
                  id: widget.todo.id,
                  title: widget.todo.title,
                  content: widget.todo.content,
                  status: "Pending",
                );

                widget.getTodoCompleted();
              },
              backgroundColor: Colors.orange.withOpacity(0.9),
              foregroundColor: Colors.white,
              icon: Icons.close,
              label: "Pending",
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.assignment_outlined,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                  child: Scrollbar(
                    controller: scrollController,
                    isAlwaysShown: true,
                    child: TextField(
                      controller: TextEditingController()
                        ..text = widget.todo.content,
                      minLines: 8,
                      maxLines: 8,
                      scrollController: scrollController,
                      readOnly: true,
                      enableInteractiveSelection: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
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
              onPressed: (context) async {
                await SqfliteDatabaseService().deleteTodo(
                  id: widget.todo.id,
                );

                widget.getTodoCompleted();
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Delete",
            ),
          ],
        ),
      ),
    );
  }
}
