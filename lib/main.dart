import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:thm/Auth/authentication.dart';
import 'package:thm/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thm/models/themeModels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Hive initialize
  await Hive.initFlutter();
  await Hive.openBox('theme');
  await Hive.openBox('settings');

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ], child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeData?>(
        future: Provider.of<ThemeProvider>(context).getTheme(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || snapshot.data == null) {
              return Center(child: Text('Error loading theme'));
            }
            ThemeData? themeData = snapshot.data;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeData,
              home: Authentication(),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
