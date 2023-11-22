import 'package:flutter/material.dart';
import 'package:thm/components/themeComponents.dart';

class themesPage extends StatefulWidget {
  const themesPage({super.key});

  @override
  State<themesPage> createState() => _themesPageState();
}

class _themesPageState extends State<themesPage> {
  @override
  Widget build(BuildContext context) {
    // MAIN
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            alignment: Alignment.center,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => Navigator.pop(context),
          );
        }),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'THEMES',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 30),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          children: [
            themeComponent(
              themeData: 'lightTheme',
              themeName: 'Light',
              themeColor: Color.fromARGB(255, 241, 238, 238),
              textColor: Colors.black,
            ),
            themeComponent(
              themeData: 'darkTheme',
              themeName: 'Dark',
              themeColor: Colors.black,
              textColor: Colors.white,
            ),
            themeComponent(
              themeData: 'bubbleTheme',
              themeName: 'Bubble Tea',
              themeColor: Color(0xffdfb593),
              textColor: Colors.white,
            ),
            themeComponent(
              themeData: 'matchaTheme',
              themeName: 'Matcha Tea',
              themeColor: Color(0xff8ba888),
              textColor: Colors.white,
            ),
            themeComponent(
              themeData: 'royalTheme',
              themeName: 'Apple',
              themeColor: Color(0xffe36262),
              textColor: Colors.white,
            ),
            themeComponent(
              themeData: 'icecreamTheme',
              themeName: 'Ice Cream',
              themeColor: Color(0xffffc5d9),
              textColor: Colors.black,
            ),
            themeComponent(
              themeData: 'midnightTheme',
              themeName: 'MidNight',
              themeColor: Color.fromARGB(255, 16, 15, 19),
              textColor: Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }
}
