import 'package:flutter/material.dart';

ThemeData bubbleTheme = ThemeData(
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xff241f1b)),
      actionsIconTheme: IconThemeData(color: Color(0xff241f1b))),
  colorScheme: ColorScheme.light(
    background: Color(0xfff2d0c4),
    inversePrimary: Color(0xfff5bfab),
    onPrimary: Color(0xffedac95),
    primary: Color(0xff241f1b),
    secondary: Color(0xff241f1b),
    surface: Color.fromARGB(255, 230, 164, 140),
  ),
  iconTheme: IconThemeData(color: Color(0xff241f1b)),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme:
          IconThemeData(color: const Color.fromARGB(255, 0, 0, 0))),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    inversePrimary: Color.fromARGB(255, 211, 210, 210),
    onPrimary: Color.fromARGB(255, 185, 183, 183),
    primary: Color.fromARGB(255, 5, 5, 5),
    secondary: Color.fromARGB(255, 66, 64, 64),
    surface: Color.fromARGB(255, 161, 158, 158),
  ),
  iconTheme: IconThemeData(color: Colors.black),
);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme:
            IconThemeData(color: Color.fromARGB(255, 252, 252, 252))),
    colorScheme: const ColorScheme.dark(
        background: Color.fromARGB(255, 29, 29, 29),
        inversePrimary: Color.fromARGB(255, 61, 60, 60),
        onPrimary: Color.fromARGB(255, 85, 85, 85),
        primary: Color.fromARGB(255, 250, 250, 250),
        secondary: Color.fromARGB(255, 184, 179, 179)));

ThemeData midnightTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme:
            IconThemeData(color: Color.fromARGB(255, 252, 252, 252))),
    colorScheme: const ColorScheme.dark(
        background: Color(0xff25232b),
        inversePrimary: Color.fromARGB(255, 18, 28, 39),
        onPrimary: Color.fromARGB(255, 61, 59, 68),
        primary: Color.fromARGB(255, 250, 250, 250),
        secondary: Color.fromARGB(255, 184, 179, 179),
        surface: Color.fromARGB(255, 56, 52, 70)));

ThemeData matchaTheme = ThemeData(
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xffc0cfb2)),
      actionsIconTheme: IconThemeData(color: Color(0xffc0cfb2))),
  colorScheme: ColorScheme.light(
    background: Color(0xff44624a),
    inversePrimary: Color(0xff8ba888),
    onPrimary: Color.fromARGB(255, 176, 189, 166),
    primary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 20, 29, 13),
    surface: Color.fromARGB(255, 92, 139, 101),
  ),
  iconTheme: IconThemeData(color: Color(0xffc0cfb2)),
  hintColor: Color.fromARGB(207, 23, 23, 23),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xff171717),
      selectionColor: Color.fromARGB(41, 23, 23, 23)),
  inputDecorationTheme:
      InputDecorationTheme(fillColor: Color.fromARGB(255, 107, 163, 119)),
);

ThemeData royalTheme = ThemeData(
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xffffcaca)),
      actionsIconTheme: IconThemeData(color: Color(0xffffcaca))),
  colorScheme: ColorScheme.light(
      background: Color(0xffc24242),
      inversePrimary: Color(0xffe36262),
      onPrimary: Color(0xffff8484),
      primary: Color.fromARGB(255, 255, 255, 255),
      secondary: Color.fromARGB(255, 253, 253, 252),
      surface: Color.fromARGB(255, 253, 148, 148)),
  iconTheme: IconThemeData(color: Color(0xffffcaca)),
  hintColor: Color.fromARGB(200, 23, 23, 23),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xff171717),
      selectionColor: Color.fromARGB(41, 23, 23, 23)),
  inputDecorationTheme: InputDecorationTheme(fillColor: Color(0xffe36262)),
);

ThemeData icecreamTheme = ThemeData(
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xffffcb85)),
      actionsIconTheme: IconThemeData(color: Color(0xff6b3e26))),
  colorScheme: ColorScheme.light(
      background: Color(0xffc2f2d0),
      inversePrimary: Color(0xffffcb85),
      onPrimary: Color(0xfffdf5c9),
      primary: Color.fromARGB(255, 70, 39, 23),
      secondary: Color.fromARGB(255, 145, 91, 62),
      surface: Color.fromARGB(255, 230, 183, 129)),
  iconTheme: IconThemeData(color: Color(0xff6b3e26)),
  hintColor: Color.fromARGB(200, 23, 23, 23),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xff171717),
      selectionColor: Color.fromARGB(41, 23, 23, 23)),
  inputDecorationTheme: InputDecorationTheme(fillColor: Color(0xfffdf5c9)),
);
