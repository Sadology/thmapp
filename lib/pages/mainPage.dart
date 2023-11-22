import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thm/Database/service.dart';
import 'package:thm/components/drawer.dart';
import 'package:thm/models/categoryModels.dart';
import 'package:thm/models/itemModels.dart';
import 'package:thm/pages/profilePage.dart';
import 'package:thm/pages/updatePage.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<CategoryModel> categories = [];
  List<ItemModel> items = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  // Version
  final version = '1.0';
  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  void _getItems() {
    items = ItemModel.getCategories();
  }

  Database() async {
    final db = await FirebaseFirestore.instance
        .collection('server')
        .doc('profile1')
        .get();

    final data = db.data();
    if (data != null) {
      if (data['Version'] != version) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdatePage()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    // Database();
    _getCategories();
    _getItems();
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profilePage())),
              icon: const Icon(
                Icons.person_2_rounded,
                size: 20,
              ),
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            'THM',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 30),
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      // PROFILE STREAM
                      StreamBuilder<UserData>(
                          stream: DatabaseService()
                              .userDataStream(currentUser?.email),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final userData = snapshot.data;

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: (Text('Hello, ${userData?.userName}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 25))),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Error ${snapshot.error}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary),
                            );
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Text(
                            'FEATURE',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            items[index].routeName)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    width: 200,
                                    child: Center(
                                        child: Text(
                                      items[index].cataName,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'CLASS',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  maintainState: false,
                                  builder: (context) =>
                                      categories[index].routeName)),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.black,
                                    backgroundImage:
                                        AssetImage(categories[index].image),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(categories[index].CourseId,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Divider(
                                      thickness: 1,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      categories[index].CourseName,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ]),
          ),
        ));
  }
}
