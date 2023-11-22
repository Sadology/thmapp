import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

// ignore: must_be_immutable
class ClassComponent extends StatelessWidget {
  final data;
  bool isFirst;
  bool isLast;
  ClassComponent(
      {super.key,
      required this.data,
      required this.isFirst,
      required this.isLast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle:
            LineStyle(color: Theme.of(context).colorScheme.inversePrimary),
        indicatorStyle: IndicatorStyle(
            width: 20, color: Theme.of(context).colorScheme.inversePrimary),
        endChild: Container(
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Date",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18)),
              const SizedBox(
                height: 5,
              ),
              Text(data,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20))
            ]),
          ),
        ),
      ),
    );
  }
}
