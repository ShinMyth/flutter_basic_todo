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

  getTodoPending() async {
    List result = await SqfliteDatabaseService().selectTodo(status: "Pending");

    listTodoPending.clear();

    setState(
      () {
        for (var value in result) {
          listTodoPending.add(
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

  showSharedDialogInsert() {
    ScrollController scrollController = ScrollController();
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

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
            TextField(
              controller: titleController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
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
                controller: contentController,
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
      actionFunction2: () async {
        await SqfliteDatabaseService().insertTodo(
          title: titleController.text,
          content: contentController.text,
          status: "Pending",
        );

        getTodoPending();

        Navigator.pop(context);
      },
      actionLabel2: const Text("Create"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listTodoPending.isEmpty
          ? const Center(
              child: Text("No pending todo"),
            )
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showSharedDialogInsert();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
