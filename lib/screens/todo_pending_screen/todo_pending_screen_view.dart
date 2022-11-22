import 'package:todosqflite/models/todo_model.dart';
import 'package:todosqflite/services/sqflite_database_service.dart';
import 'package:todosqflite/shared/shared_dialog.dart';
import 'package:todosqflite/widgets/custom_cards.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodoPendingScreenView extends StatefulWidget {
  const TodoPendingScreenView({Key? key}) : super(key: key);

  @override
  State<TodoPendingScreenView> createState() => _TodoPendingScreenViewState();
}

class _TodoPendingScreenViewState extends State<TodoPendingScreenView> {
  List<Todo> listTodoPending = <Todo>[];

  @override
  void initState() {
    getTodoPending();
    super.initState();
  }

  // Get all todo's with status of pending
  void getTodoPending() async {
    List result = await SqfliteDatabaseService().selectTodo(status: "Pending");

    setState(
      () {
        listTodoPending.clear();

        for (var value in result) {
          listTodoPending.add(Todo.fromMap(value));
        }
      },
    );
  }

  void showSharedDialogTodoInsert() {
    ScrollController scrollController = ScrollController();
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

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
          await SqfliteDatabaseService().insertTodo(
            title: titleController.text,
            content: contentController.text,
            status: "Pending",
          );

          getTodoPending();

          Navigator.pop(context);
        }
      },
      actionLabel2: const Text("Create"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listTodoPending.isEmpty
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
                    "You have no pending todo's\nat this moment.",
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
                itemCount: listTodoPending.length,
                itemBuilder: (context, index) {
                  return TodoPendingCard(
                    todo: listTodoPending[index],
                    getTodoPending: () => getTodoPending(),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSharedDialogTodoInsert();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
