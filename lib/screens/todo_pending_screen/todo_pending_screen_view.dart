import 'package:todosqflite/models/todo_model.dart';
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
  showSharedDialogCreate() {
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
      actionLabel2: const Text("Create"),
    );
  }

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
              TodoPendingCard(
                todo: Todo(
                  title: "Todo #1",
                  content: "asdas\nasdas",
                ),
              ),
              TodoPendingCard(
                todo: Todo(
                  title: "Todo #2",
                  content: "asdas\nasdas\nasdas",
                ),
              ),
              TodoPendingCard(
                todo: Todo(
                  title: "Todo #3",
                  content:
                      "asdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\n",
                ),
              ),
              TodoPendingCard(
                todo: Todo(
                  title: "Todo #5",
                  content:
                      "asdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\nasdas\n",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showSharedDialogCreate();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
