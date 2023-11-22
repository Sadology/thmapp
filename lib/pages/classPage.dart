import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thm/models/categoryModels.dart';
import 'package:thm/pages/homepage.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});
  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  List<CategoryModel> categories = [];
  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: Text(
          'CLASS',
          style: TextStyle(
              fontSize: 30, color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            alignment: Alignment.center,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Theme.of(context).iconTheme.color,
            ),
            color: Colors.black,
            onPressed: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      maintainState: false, builder: (context) => HomePage()))
            },
          );
        }),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      // BODY
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            // DATE: TODAY
            Text(
              "Today - ${DateFormat.yMMMEd().format(DateTime.now())}",
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              // STREAM BUILDER
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Classes')
                      .orderBy('Date', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                          docs = snapshot.data!.docs;

                      // Filter the list
                      final timeNow = DateTime.now();
                      final newDoc = docs
                          .where((element) =>
                              element['Date'].toDate().isAfter(timeNow) ||
                              element['Date'].toDate().year == timeNow.year &&
                                  element['Date'].toDate().month ==
                                      timeNow.month &&
                                  element['Date'].toDate().day == timeNow.day)
                          .toList();

                      // Build the list
                      return ListView.builder(
                        itemCount: newDoc.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          final doc = newDoc[index];
                          final rawDate = doc["Date"].toDate();
                          final formatDate =
                              DateFormat.yMMMEd().format(rawDate);
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      maintainState: false,
                                      builder: (context) =>
                                          categories[doc["Code"]].routeName)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: ListTile(
                                  title: Text(
                                    '$formatDate  -  ${doc['Time']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          categories[doc["Code"]].CourseName,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          categories[doc["Code"]].TeacherName,
                                          style: TextStyle(
                                            fontSize: 16,
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
                                              ? "Class Canceled"
                                              : 'Room - ${doc['Room']}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
