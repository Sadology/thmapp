import 'package:flutter/material.dart';
import 'package:thm/pages/ExamPage.dart';
import 'package:thm/pages/assignmenPage.dart';
import 'package:thm/pages/comingsoonPage.dart';

class ItemModel {
  String cataName;
  Color boxColor;
  final routeName;
  ItemModel({
    required this.cataName,
    required this.boxColor,
    required this.routeName,
  });

  static List<ItemModel> getCategories() {
    List<ItemModel> categories = [];
    categories.add(ItemModel(
        cataName: "Exams",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        routeName: ExamPage()));
    categories.add(ItemModel(
        cataName: "Assignments",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        routeName: AssignmentPage()));

    categories.add(ItemModel(
        cataName: "Coming Soon",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        routeName: ComingSoon()));
    categories.add(ItemModel(
        cataName: "Coming Soon",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        routeName: ComingSoon()));
    categories.add(ItemModel(
        cataName: "Coming Soon",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        routeName: ComingSoon()));
    return categories;
  }
}
