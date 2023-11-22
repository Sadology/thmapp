import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:thm/theme/multiTheme.dart';

class ThemeProvider with ChangeNotifier {
  bool _newTheme = false;
  bool get newTheme => _newTheme;
  ThemeData _appTheme = darkTheme;
  ThemeData get appTheme => _appTheme;

  Future<ThemeData?> getTheme() async {
    try {
      final dbox = await Hive.box('theme');
      String themedata = dbox.get('themeData') ?? 'darkTheme';

      if (themedata == "lightTheme") {
        return _appTheme = lightTheme;
      } else if (themedata == "darkTheme") {
        return _appTheme = darkTheme;
      } else if (themedata == 'bubbleTheme') {
        return _appTheme = bubbleTheme;
      } else if (themedata == 'matchaTheme') {
        return _appTheme = matchaTheme;
      } else if (themedata == 'royalTheme') {
        return _appTheme = royalTheme;
      } else if (themedata == 'icecreamTheme') {
        return _appTheme = icecreamTheme;
      } else if (themedata == 'midnightTheme') {
        return _appTheme = midnightTheme;
      }

      ChangeNotifier();
    } catch (e) {
      return _appTheme = lightTheme;
    }
    return null;
  }

  void toggleDarkTheme() async {
    _newTheme = !_newTheme;
    var box = await Hive.box('theme');
    if (_newTheme) {
      _appTheme = darkTheme;
      box.put('newTheme', _newTheme);
      notifyListeners();
    } else {
      _appTheme = lightTheme;
      box.put('newTheme', _newTheme);
      notifyListeners();
    }
  }

  void toggleTheme(String themeName) async {
    final dbox = await Hive.box('theme');

    switch (themeName) {
      case "bubbleTheme":
        _appTheme = bubbleTheme;
      case "lightTheme":
        _appTheme = lightTheme;
      case "darkTheme":
        _appTheme = darkTheme;
      case "matchaTheme":
        _appTheme = matchaTheme;
      case "royalTheme":
        _appTheme = royalTheme;
      case "icecreamTheme":
        _appTheme = icecreamTheme;
      case "midnightTheme":
        _appTheme = midnightTheme;
    }
    dbox.put('themeData', themeName);
    notifyListeners();
  }
}
