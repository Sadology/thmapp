// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final THMpasswordController = TextEditingController();

  showSnackBar(String Value) {
    final textbar = Value;
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        passwordController.text.isNotEmpty &&
        THMpasswordController.text.isNotEmpty &&
        THMpasswordController.text.toLowerCase() == '') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            dialogContext = context;
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ));
          });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userNameController.text, password: passwordController.text);

        if (!context.mounted) return;
        Navigator.of(dialogContext!).pop();
      } on FirebaseAuthException catch (e) {
        Navigator.of(dialogContext!).pop();
        showSnackBar(e.code);
      }
    } else {
      showSnackBar("Please fill out the fields");
    }
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
                hintText: "Email",
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
              controller: passwordController,
              cursorColor: Theme.of(context).colorScheme.primary,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.0,
                  ),
                ),
                hintText: "Password",
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
                        color: Theme.of(context).colorScheme.primary)),
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
                      "Login",
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
                Text("Don't have an account?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register Now',
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
