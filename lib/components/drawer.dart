import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thm/Auth/login_register.dart';
import 'package:thm/Database/service.dart';
import 'package:thm/pages/classPage.dart';
import 'package:thm/pages/noticePage.dart';
import 'package:thm/pages/profilePage.dart';
import 'package:thm/pages/routinePage.dart';
import 'package:thm/pages/settingsPage.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            Container(
              height: 200,
              width: 1000,
              child: StreamBuilder<UserData>(
                  stream: DatabaseService().userDataStream(currentUser?.email),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData = snapshot.data;
                      return DrawerHeader(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              image: DecorationImage(
                                  image: NetworkImage('${userData?.Avatar}'),
                                  fit: BoxFit.cover)),
                          child: const Text(''));
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error ${snapshot.error}',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                onTap: () => Navigator.pop(context),
                title: Text(
                  "HOME",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Divider(color: Colors.grey, height: 5),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const profilePage()));
                },
                title: Text(
                  "PROFILE",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Divider(color: Colors.grey, height: 5),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
              child: ListTile(
                leading: Icon(
                  Icons.school,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClassPage()));
                },
                title: Text(
                  "CLASS",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Divider(color: Colors.grey, height: 5),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.calendar,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const routinePage()))
                },
                title: Text(
                  "ROUTINE",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Divider(color: Colors.grey, height: 5),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.app_badge,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const noticePage()))
                },
                title: Text(
                  "NOTICE",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Divider(color: Colors.grey, height: 5),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const settingsPage()))
                },
                title: Text(
                  "SETTINGS",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Login_Register()));
            },
            title: Text(
              "LOGOUT",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 20),
            ),
          ),
        )
      ]),
    );
  }
}
