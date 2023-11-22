import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final THMpasswordController = TextEditingController();

  showSnackBar(String Value) {
    final textbar = Value;
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: Text(
        textbar,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void passCheck() async {
    BuildContext? dialogContext;
    if (userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        THMpasswordController.text.isNotEmpty &&
        THMpasswordController.text.toLowerCase() == '') {
      try {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              dialogContext = context;
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ));
            });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        // Pop Circular
        if (!context.mounted) return;
        Navigator.of(dialogContext!).pop();

        // Create profile page
        FirebaseFirestore.instance
            .collection("Registry")
            .doc(userCredential.user!.email)
            .set({
          'userName': userNameController.text,
          'password': passwordController.text,
          'Avatar': '',
          'Roll': '',
          'Merit': '',
          'isAdmin': false,
          'Bio': '',
          'timestamp': Timestamp.now()
        });
      } on FirebaseAuthException catch (e) {
        Navigator.of(dialogContext!).pop();
        showSnackBar(e.code);
      }
    } else {
      showSnackBar('Please fill out the fields');
    }
  }

  void showErrosMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Center(
                child: Text(
              message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, fontSize: 20),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.fromLTRB(35, 0, 25, 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "THM FAMILY",
                      style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              obscureText: false,
              keyboardType: TextInputType.text,
              controller: userNameController,
              cursorColor: Theme.of(context).colorScheme.primary,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.0,
                  ),
                ),
                hintText: "username",
                hintStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              obscureText: false,
              keyboardType: TextInputType.text,
              controller: emailController,
              cursorColor: Theme.of(context).colorScheme.primary,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.0,
                  ),
                ),
                hintText: "Use a fake email e.g yourname@gmail.com",
                hintStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              obscureText: false,
              keyboardType: TextInputType.text,
              controller: passwordController,
              cursorColor: Theme.of(context).colorScheme.primary,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.0,
                  ),
                ),
                hintText: "6+ Digit Password",
                hintStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              obscureText: false,
              keyboardType: TextInputType.text,
              controller: THMpasswordController,
              cursorColor: Theme.of(context).colorScheme.primary,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.0,
                  ),
                ),
                hintText: "Thm Password",
                hintStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                return passCheck();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Join",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
