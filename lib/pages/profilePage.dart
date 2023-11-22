import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thm/Database/service.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection('Registry');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String newUser = '';
  String newBio = '';
  String newRoll = '';
  String newMerit = '';
  Uint8List? _image;
// SNAKBAR
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

// DATABASE FUNTION
  uploadImage(name, Uint8List file) async {
    Reference ref = _storage.ref().child(name.toString());
    UploadTask uploadtask = ref.putData(file);
    TaskSnapshot snapshot = await uploadtask;
    String DownloadUrl = await snapshot.ref.getDownloadURL();

    return DownloadUrl;
  }

  void saveData() async {
    // NAME UPLOAD
    if (newUser.trim().isNotEmpty) {
      await userCollection
          .doc(currentUser?.email)
          .update({'userName': newUser})
          .then((value) => showSnackBar('Username Updated'))
          .catchError((error) => showSnackBar("Failed to update: $error"));
    }
    // BIO UPLOAD
    if (newBio.trim().length > 0) {
      await userCollection
          .doc(currentUser?.email)
          .update({'Bio': newBio})
          .then((value) => showSnackBar('About Me Updated'))
          .catchError((error) => showSnackBar("Failed to update: $error"));
    }
    // IMAGE UPLOAD
    if (_image != null) {
      String imageUrl = await uploadImage(currentUser?.email, _image!);
      await userCollection
          .doc(currentUser?.email)
          .update({'Avatar': imageUrl})
          .then((value) => showSnackBar('Avatar Uploaded'))
          .catchError((error) => showSnackBar("Failed to upload: $error"));
    }
    if (newRoll.trim().length > 0) {
      await userCollection
          .doc(currentUser?.email)
          .update({'Roll': newRoll})
          .then((value) => showSnackBar('Roll Number Updated'))
          .catchError((error) => showSnackBar("Failed to update: $error"));
    }

    if (newMerit.trim().length > 0) {
      await userCollection
          .doc(currentUser?.email)
          .update({'Merit': newMerit})
          .then((value) => showSnackBar('Merit Position Updated'))
          .catchError((error) => showSnackBar("Failed to update: $error"));
    }
  }

// IMAGE PICKER

  PickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1080,
        maxWidth: 1980,
        imageQuality: 80);

    if (file != null) {
      return await file.readAsBytes();
    }
  }

  void selectimage() async {
    Uint8List? img = await PickImage();

    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // APPBAR
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => Navigator.pop(context),
          );
        }),
        // SAVE BUTTON
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () => {saveData()},
              child: Text(
                "SAVE",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )
        ],

        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'PROFILE',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 30),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: StreamBuilder<UserData>(
              stream: DatabaseService().userDataStream(currentUser?.email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData = snapshot.data;
                  String imageurl = userData?.Avatar ??
                      "https://media.discordapp.net/attachments/1173656243139788900/1173656309321715822/download.png?ex=6564bf9d&is=65524a9d&hm=829675fa6d28bedb531bc2dfc0ddf1dea83b398c1422c6928058ba5ed705b26a&=";

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Stack(
                              children: [
                                if (_image != null)
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                else
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.black,
                                    backgroundImage: NetworkImage(imageurl),
                                  ),
                                Positioned(
                                  left: 65,
                                  top: -1,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        onPressed: () {
                                          selectimage();
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 15,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (userData?.isAdmin == true)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Class Representative",
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          // USER NAME
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Username",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // USER NAME TEXT BOX
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLength: 50,
                                    initialValue: userData?.userName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    decoration: InputDecoration(
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary))),
                                    onChanged: (value) {
                                      newUser = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // EMAIL TEXT
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // EMAIL TEXT BOX
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLength: 50,
                                    readOnly: true,
                                    initialValue: currentUser!.email,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // ROLL AND MERIT
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Roll",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Merit",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // ROLL AND MERIT TEXT BOX
                          Row(
                            children: [
                              Expanded(
                                // ROLL
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                          minLines: 1,
                                          maxLines: 1,
                                          maxLength: 3,
                                          keyboardType: TextInputType.number,
                                          initialValue: userData?.Roll,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          decoration: InputDecoration(
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.all(15),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary))),
                                          onChanged: (value) {
                                            newRoll = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // MERIT
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                          minLines: 1,
                                          maxLines: 1,
                                          maxLength: 6,
                                          keyboardType: TextInputType.number,
                                          initialValue: userData?.Merit,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          decoration: InputDecoration(
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.all(15),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary))),
                                          onChanged: (value) {
                                            newMerit = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ABOUT ME TEXT
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "About Me",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ABOUT ME TEXT BOX
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    maxLines: 10,
                                    maxLength: 300,
                                    initialValue: userData?.Bio,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    decoration: InputDecoration(
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary))),
                                    onChanged: (value) {
                                      newBio = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error ${snapshot.error}'),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary),
                );
              }),
        ),
      ),
    );
  }
}
