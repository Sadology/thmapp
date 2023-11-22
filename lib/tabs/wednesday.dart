// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WednesdayTab extends StatelessWidget {
  const WednesdayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              color: Colors.transparent,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "Time",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "Course",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "Room",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ])),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "11.00 AM",
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "Basic English Language",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "5003",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
