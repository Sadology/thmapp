import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thm/pages/noticePage.dart';

class AddAnnounce extends StatefulWidget {
  const AddAnnounce({super.key});

  @override
  State<AddAnnounce> createState() => _AddAnnounceState();
}

class _AddAnnounceState extends State<AddAnnounce> {
  final TextController = TextEditingController();

  showSnackBar(String Value) {
    final textbar = Value;
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: Text(
        textbar,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // DATABASE
  saveData() {
    if (TextController.text.isEmpty) {
      showSnackBar('Please Type Your Message');
    } else {
      try {
        FirebaseFirestore.instance.collection("Notice").add({
          'message': TextController.text,
          'userEmail': FirebaseAuth.instance.currentUser?.email,
          'timestamp': Timestamp.now()
        }).then((value) {
          showSnackBar('Notice Posted');
          Navigator.pop(context);
        }).catchError((error) => showSnackBar('There was an error $error'));
      } on FirebaseAuthException catch (e) {
        showSnackBar(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // APPBAR
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
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () => {saveData()},
              child: Text(
                "POST",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      // BODY
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Create Announcement",
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: TextController,
              minLines: 5,
              maxLines: 20,
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.secondary),
              decoration: InputDecoration(
                  hintText: "Message",
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ]),
      ),
    );
  }
}
