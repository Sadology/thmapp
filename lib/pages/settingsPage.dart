import 'package:flutter/material.dart';
import 'package:thm/pages/themesPage.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
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
          'SETTINGS',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 30),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(15)),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => themesPage()));
                },
                child: ListTile(
                  title: Text(
                    'Themes',
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  subtitle: Text("Change app theme",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary)),
                )),
          ),
        ]),
      ),
    );
  }
}
