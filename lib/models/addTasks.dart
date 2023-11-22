import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thm/pages/forumPage.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime currentDate = DateTime.now();
  final dateController = TextEditingController();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = "00: 00 AM";
  getDate() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));

    if (pickDate != null) {
      setState(() {
        currentDate = pickDate;
      });
    } else {
      currentDate = currentDate;
    }
  }

  getTime({required bool timersSettings}) async {
    var pickedTime = await TimePicker();
    if (pickedTime == null) {
      return;
    }
    String formatTime = pickedTime.format(context);
    if (timersSettings == true) {
      setState(() {
        startTime = formatTime;
      });
    } else if (timersSettings == false) {
      setState(() {
        endTime = formatTime;
      });
    }
  }

  TimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(':')[0]),
            minute: int.parse(startTime.split(':')[1].split(' ')[0])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            color: Colors.black,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  maintainState: false,
                  builder: (context) => const forumPage(),
                )),
          );
        }),
        backgroundColor: Colors.transparent,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: const Text(
            "Add Task",
            style: TextStyle(fontSize: 30),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                hintText: "Title",
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                hintText: "Description",
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
                filled: true,
                hintText: DateFormat.yMMMd().format(currentDate),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    getDate();
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text(
                  'Start Time',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text(
                  'End TIme',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    hintText: startTime,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time_rounded),
                      onPressed: () {
                        getTime(timersSettings: true);
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    hintText: endTime,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time_rounded),
                      onPressed: () {
                        getTime(timersSettings: false);
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ))
          ],
        )
      ]),
    );
  }
}
