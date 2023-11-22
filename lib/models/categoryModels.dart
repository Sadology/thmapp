import 'package:flutter/material.dart';
import 'package:thm/pages/courseDetails.dart';

class CategoryModel {
  String CourseName;
  String TeacherName;
  String CourseId;
  Color boxColor;
  String image;

  final routeName;
  CategoryModel(
      {required this.CourseName,
      required this.TeacherName,
      required this.CourseId,
      required this.boxColor,
      required this.routeName,
      required this.image});

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    categories.add(CategoryModel(
        CourseName: "Introduction to Business",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        TeacherName: 'Prof. Santus Kumar Deb',
        CourseId: '111',
        image: 'assets/icons/chairmansir.jpg',
        routeName: CourseDetails(
          courseNumber: 0,
        )));
    categories.add(CategoryModel(
        CourseName: "Fundamentals of Tourism & Hospitality Management",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        TeacherName: 'Dr. Saud Ahmed',
        CourseId: '112',
        image: 'assets/icons/saudsir.jpg',
        routeName: CourseDetails(
          courseNumber: 1,
        )));

    categories.add(CategoryModel(
        CourseName: "Introduction to Computer",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        TeacherName: 'Ms. Jameni Jabed Suchana',
        CourseId: '113',
        image: 'assets/icons/jamenimam.jpg',
        routeName: CourseDetails(
          courseNumber: 2,
        )));
    categories.add(CategoryModel(
        CourseName: "Basic English Language",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        TeacherName: 'Prof. Dr. Md. Kazal Krishna Banerjee',
        CourseId: '114',
        image: 'assets/icons/kazalsir.jpg',
        routeName: CourseDetails(
          courseNumber: 3,
        )));

    categories.add(CategoryModel(
        CourseName: "Bangladesh Studies",
        boxColor: Color.fromARGB(255, 138, 134, 134),
        TeacherName: 'Prof. Dr. Md. Rafiqul Islam',
        CourseId: '115',
        image: 'assets/icons/rafiqsir.jpg',
        routeName: CourseDetails(
          courseNumber: 4,
        )));
    ;
    return categories;
  }
}
