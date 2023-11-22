import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thm/components/classComponents.dart';
import 'package:thm/models/addAssignment.dart';
import 'package:thm/models/addClass.dart';
import 'package:thm/models/addExam.dart';
import 'package:thm/models/categoryModels.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CourseDetails extends StatefulWidget {
  int courseNumber;
  CourseDetails({super.key, required this.courseNumber});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  List<CategoryModel> categories = [];
  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

//SNACKBAR
  showSnackBar(Value) {
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

  DeleteMessage(messageID, fieldtype, queryType) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Text("Delete ${fieldtype}"),
              content:
                  Text("Are you sure you want to delete this ${fieldtype}?"),
              actions: [
                TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);

                      await FirebaseFirestore.instance
                          .collection(queryType)
                          .doc(messageID)
                          .delete()
                          .then(
                              (value) => showSnackBar("${fieldtype} Deleted!"))
                          .catchError((error) =>
                              showSnackBar("Failed to Delete: $error"));
                    },
                    child: const Text("Yes")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
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
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => {
                Navigator.pop(context),
              },
            );
          }),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        // LAYOUT
        body: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // LAYOUT PANELS
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // CORUSE LAYOUT

              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10)),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black,
                      backgroundImage:
                          AssetImage(categories[widget.courseNumber].image),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(
                        height: 10,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(categories[widget.courseNumber].TeacherName,
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'THM-${categories[widget.courseNumber].CourseId}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      categories[widget.courseNumber].CourseName,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // CLASS LAYOUT
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10)),
                height: 450,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Text(
                              'Class',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            margin: EdgeInsets.only(top: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      maintainState: false,
                                      builder: (context) => AddClass(
                                          classCode: widget.courseNumber),
                                    )),
                                icon: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                          )
                        ],
                      ),
                      // DATABASE STREAM
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Classes')
                              .doc(categories[widget.courseNumber]
                                  .CourseId
                                  .toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map Class = (snapshot.data!.data() ?? {}) as Map;
                              final date = Class['Date'] == null
                                  ? "Error"
                                  : DateFormat.yMMMd()
                                      .format(Class['Date'].toDate());
                              final week = Class['Date'] == null
                                  ? "Error"
                                  : DateFormat('EEEE')
                                      .format(Class['Date'].toDate());

                              final startsat = Class['Time'] ?? 'Error';
                              final room = Class['Room'] ?? 'Error';

                              // CHECK IF DATE IS BEFORE TODAY
                              final timeNow = DateTime.now();
                              final classTime = Class['Date'].toDate();
                              if (classTime.isAfter(timeNow) ||
                                  classTime.year == timeNow.year &&
                                      classTime.month == timeNow.month &&
                                      classTime.day == timeNow.day) {
                                // TIMELINE
                                return SizedBox(
                                  height: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          ClassComponent(
                                            data: date,
                                            isFirst: true,
                                            isLast: false,
                                          ),
                                          ClassComponent(
                                            data: week,
                                            isFirst: false,
                                            isLast: false,
                                          ),
                                          ClassComponent(
                                            data: room,
                                            isFirst: false,
                                            isLast: false,
                                          ),
                                          ClassComponent(
                                            data: startsat,
                                            isFirst: false,
                                            isLast: true,
                                          ),
                                        ]),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "No Class Today 😃",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 25),
                                  ),
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error ${snapshot.error}'),
                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary),
                            );
                          }),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              // EXAM SURFACE
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Text(
                              'Exams',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).colorScheme.primary),
                            )),
                        Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    maintainState: false,
                                    builder: (context) =>
                                        AddExam(classCode: widget.courseNumber),
                                  )),
                              icon: Icon(
                                Icons.add,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              )),
                        )
                      ],
                    ),
                    // EXAM LIST
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('Exams')
                              .where('Code', isEqualTo: widget.courseNumber)
                              .orderBy("Date", descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final List<
                                      QueryDocumentSnapshot<
                                          Map<String, dynamic>>> docs =
                                  snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: docs.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (_, index) {
                                  final doc = docs[index];
                                  final rawDate = doc["Date"].toDate();
                                  final formatDate =
                                      DateFormat.yMMMEd().format(rawDate);

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 0, 10),
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$formatDate  ${doc['Time'] == "Exam Canceled" ? '' : doc['Time']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            Container(
                                              height: 33,
                                              width: 33,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: IconButton(
                                                  onPressed: () {
                                                    DeleteMessage(doc.id,
                                                        'Exam', 'Exams');
                                                  },
                                                  icon: Icon(
                                                    CupertinoIcons.delete,
                                                    size: 15,
                                                  )),
                                            )
                                          ],
                                        ),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                doc['Topic'].toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                doc['Canceled'] == true
                                                    ? "Exam Canceled"
                                                    : 'Room - ${doc['Room']}',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ]),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error ${snapshot.error}'));
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // ASSIGNMENT LAYOUT
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 5),
                        child: Text(
                          'Assignments',
                          style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  maintainState: false,
                                  builder: (context) => AddAssignment(
                                      classCode: widget.courseNumber),
                                )),
                            icon: Icon(
                              Icons.add,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                      )
                    ],
                  ),
                  // ASSIGNMENT LIST
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('Assignment')
                            .where('Code', isEqualTo: widget.courseNumber)
                            .orderBy("Date", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            final List<
                                    QueryDocumentSnapshot<Map<String, dynamic>>>
                                docs = snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: docs.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (_, index) {
                                final doc = docs[index];
                                final rawDate = doc["Date"].toDate();
                                final formatDate =
                                    DateFormat.yMMMEd().format(rawDate);

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 10),
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '$formatDate  ${doc['Time']}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Container(
                                            height: 33,
                                            width: 33,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: IconButton(
                                                onPressed: () {
                                                  DeleteMessage(
                                                      doc.id,
                                                      'Assignment',
                                                      'Assignment');
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.delete,
                                                  size: 15,
                                                )),
                                          )
                                        ],
                                      ),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              doc['Topic'].toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error ${snapshot.error}'),
                            );
                          }
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          );
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
