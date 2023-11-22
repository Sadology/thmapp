import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thm/models/addTasks.dart';
import 'package:thm/pages/homepage.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class forumPage extends StatelessWidget {
  const forumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            alignment: Alignment.center,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
            color: Colors.black,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  maintainState: false,
                  builder: (context) => const HomePage(),
                )),
          );
        }),
        backgroundColor: Colors.transparent,
        title: const Text(
          'TASKS',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('Today', style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      maintainState: false,
                      builder: (context) => const AddTask(),
                    )),
                child: Container(
                  height: 55,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 89, 69, 201)),
                  child: const Center(
                    child: Text(
                      '+ New Task',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          child: DatePicker(
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
          ),
        ),
      ]),
    );
  }
}
