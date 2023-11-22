import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thm/models/categoryModels.dart';

// ignore: must_be_immutable
class AddClass extends StatefulWidget {
  int classCode;
  AddClass({super.key, required this.classCode});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  List<CategoryModel> categories = [];
  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  bool isCanceled = false;
  DateTime currentDate = DateTime.now();
  final roomController = TextEditingController();

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

  showSnackBar(String Value) {
    final textbar = Value;
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: Text(
        textbar,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  saveData() {
    if (isCanceled == false && roomController.text.isEmpty) {
      showSnackBar('Please Fill The Room Number');
    } else {
      try {
        FirebaseFirestore.instance
            .collection("Classes")
            .doc(categories[widget.classCode].CourseId.toString())
            .set({
          'Code': widget.classCode,
          'Date': currentDate,
          'Time': isCanceled == true ? "Class Canceled" : startTime,
          'Room': isCanceled == true ? "Class Canceled" : roomController.text,
          'Canceled': isCanceled,
          'timestamp': Timestamp.now()
        }).then((value) {
          showSnackBar('Class Updated');
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
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Add Class",
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Course Name',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )),
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
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Room Number',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: roomController,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 18),
              decoration: InputDecoration(
                  filled: true,
                  hintText: "5003",
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
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Canceled',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  )),
              Checkbox(
                  checkColor: Theme.of(context).iconTheme.color,
                  activeColor: Theme.of(context).colorScheme.onPrimary,
                  value: isCanceled,
                  onChanged: (bool? value) {
                    setState(() {
                      isCanceled = value!;
                    });
                  })
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Date',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Starts At',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: DateFormat.yMMMd().format(currentDate),
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today_outlined,
                              color: Theme.of(context).colorScheme.primary),
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
                  child: TextFormField(
                    readOnly: true,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18),
                    decoration: InputDecoration(
                        hintText: startTime,
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
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
              )
            ],
          ),
        ]),
      ),
    );
  }
}
