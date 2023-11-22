import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thm/models/themeModels.dart';

// ignore: must_be_immutable
class themeComponent extends StatelessWidget {
  String themeData;
  String themeName;
  Color themeColor;
  Color textColor;
  themeComponent(
      {super.key,
      required this.themeData,
      required this.themeName,
      required this.themeColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        themeProvider.toggleTheme(themeData);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
              color: themeColor, borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            title: Text(
              themeName,
              style: TextStyle(color: textColor, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
