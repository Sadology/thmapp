import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thm/models/categoryModels.dart';

// ignore: must_be_immutable
class AddAssignment extends StatefulWidget {
  int classCode;
  AddAssignment({super.key, required this.classCode});

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  List<CategoryModel> categories = [];
  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  DateTime currentDate = DateTime.now();
  final topicController = TextEditingController();

  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  getDate() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color.fromARGB(255, 255, 255, 255),
                onSurface: Color.fromARGB(255, 255, 255, 255),
              ),
              dialogBackgroundColor: Color.fromARGB(255, 32, 32, 32)),
          child: child!,
        );
      },
    );

    if (pickDate != null) {
      setState(() {
        currentDate = pickDate;
      });
    } else {
      currentDate = currentDate;
    }
  }

  getTime() async {
    var pickedTime = await TimePicker();
    if (pickedTime == null) {
      return;
    }

    String formatTime = pickedTime.format(context);
    setState(() {
      startTime = formatTime;
    });
  }

  TimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
              primary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 255, 255, 255),
            )),
            child: child!,
          );
        },
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(':')[0]),
            minute: int.parse(startTime.split(':')[1].split(' ')[0])));
  }

  // SNACKBAR
  showSnackBar(String Value) {
    final textbar = Value;
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: Text(
        textbar.toString(),
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // SAVE TO DATABSE
  saveData() async {
    if (topicController.text.isEmpty) {
      showSnackBar('Please Fill The Assignment Topic');
    } else {
      try {
        // SAVE TO DATABASE
        await FirebaseFirestore.instance.collection("Assignment").add({
          'Code': widget.classCode,
          'Date': currentDate,
          'Topic': topicController.text,
          'Time': startTime,
          'timestamp': Timestamp.now()
        }).then((value) {
          showSnackBar('Assignment Added');
          Navigator.pop(context);
        }).catchError((error) => showSnackBar('There was an error $error'));
      } on FirebaseAuthException catch (e) {
        showSnackBar(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // APPBAR
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
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => Navigator.pop(context),
          );
        }),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () => {saveData()},
              child: Text(
                "SAVE",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      // BODY
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Add Assignment",
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Course Name',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Code',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    initialValue: categories[widget.classCode].CourseName,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18),
                    decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    readOnly: true,
                    initialValue: categories[widget.classCode].CourseId,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18),
                    decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // SYLLEBUS TEXT
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Topic',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              )),
          const SizedBox(
            height: 5,
          ),
          // SYLLEBUS FIELD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              maxLines: 3,
              controller: topicController,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 18),
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Case study 1",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Due Date',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Ends At',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: DateFormat.yMMMd().format(currentDate),
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today_outlined),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            getDate();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: startTime,
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time_rounded,
                              color: Theme.of(context).colorScheme.primary),
                          onPressed: () {
                            getTime();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
