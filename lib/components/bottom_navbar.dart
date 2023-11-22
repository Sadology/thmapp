import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.background,
      child: GNav(
          gap: 10,
          color: Theme.of(context).iconTheme.color,
          activeColor: Theme.of(context).colorScheme.primary,
          tabBackgroundColor: Theme.of(context).colorScheme.onPrimary,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabBorderRadius: 15,
          curve: Curves.easeInExpo,
          padding: EdgeInsets.all(20),
          onTabChange: (value) => onTabChange!(value),
          tabs: [
            GButton(
              icon: CupertinoIcons.home,
              text: 'Home',
              iconColor: Theme.of(context).iconTheme.color,
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            GButton(
              icon: Icons.school,
              text: 'Class',
              iconColor: Theme.of(context).iconTheme.color,
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            GButton(
              icon: CupertinoIcons.calendar,
              text: "Routine",
              iconColor: Theme.of(context).iconTheme.color,
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            GButton(
              icon: CupertinoIcons.app_badge,
              text: 'Notice',
              iconColor: Theme.of(context).iconTheme.color,
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ]),
    );
  }
}
