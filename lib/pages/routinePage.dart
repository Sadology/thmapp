// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:thm/pages/homepage.dart';
import 'package:thm/tabs/monday.dart';
import 'package:thm/tabs/sunday.dart';
import 'package:thm/tabs/thursday.dart';
import 'package:thm/tabs/tuesday.dart';
import 'package:thm/tabs/wednesday.dart';

class routinePage extends StatelessWidget {
  const routinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
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
                color: Theme.of(context).colorScheme.primary,
                onPressed: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          maintainState: false,
                          builder: (context) => HomePage()))
                },
              );
            }),
            backgroundColor: Colors.transparent,
            title: Text(
              'ROUTINE',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 30),
            ),
          ),
          body: Column(children: <Widget>[
            TabBar(tabs: [
              Tab(
                child: Text(
                  "SUN",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Tab(
                child: Text("MON",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              Tab(
                child: Text("TUE",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              Tab(
                child: Text("WED",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              Tab(
                child: Text("THU",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ]),
            Expanded(
                child: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                SunDayTab(),
                MondayTab(),
                TuesdayTab(),
                WednesdayTab(),
                ThursdayTab(),
              ],
            ))
          ]),
          backgroundColor: Theme.of(context).colorScheme.background,
        ));
  }
}
