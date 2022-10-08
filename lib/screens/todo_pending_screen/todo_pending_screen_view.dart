import 'package:todosqflite/models/todo_model.dart';
import 'package:todosqflite/screens/todo_input_screen/todo_input_screen_view.dart';
import 'package:todosqflite/widgets/custom_cards.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// import 'package:flutter_spinkit/flutter_spinkit.dart';

class TodoPendingScreenView extends StatefulWidget {
  const TodoPendingScreenView({Key? key}) : super(key: key);

  @override
  State<TodoPendingScreenView> createState() => _TodoPendingScreenViewState();
}

class _TodoPendingScreenViewState extends State<TodoPendingScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
          child: Column(
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
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   barrierColor: Colors.transparent,
          //   builder: (BuildContext context) {
          //     return WillPopScope(
          //       onWillPop: () async {
          //         return false;
          //       },
          //       child: const SpinKitCircle(
          //         color: Colors.purple,
          //         size: 50.0,
          //       ),
          //     );
          //   },
          // );

          // await Future.delayed(const Duration(seconds: 2), () {
          //   Navigator.pop(context);
          // });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoInputScreenView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
