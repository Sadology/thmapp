import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thm/components/profileFetch.dart';
import 'package:thm/models/addAnnounce.dart';
import 'package:thm/pages/homepage.dart';
import 'package:flutter/services.dart';

class noticePage extends StatefulWidget {
  const noticePage({super.key});

  @override
  State<noticePage> createState() => _noticePageState();
}

class _noticePageState extends State<noticePage> {
  final textController = TextEditingController();
  final ScrollController _controller = ScrollController();
  final currentUser = FirebaseAuth.instance.currentUser;

  // SCROLL CONTROLLER
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.ease,
    );
  }

  // SNACKBAR FUNCTION
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

  // COPY FUNTION
  copyFunction(message) async {
    await Clipboard.setData(ClipboardData(text: message));
    showSnackBar('Copied to clipboard');
  }

  showProfileModal(email) async {
    final db = await FirebaseFirestore.instance
        .collection("Registry")
        .doc(email)
        .get()
        .catchError((error) {
      showSnackBar("Something went wrong $error");
      Navigator.pop(context);
    });
    final data = db.data();
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        context: context,
        builder: (context) {
          return profileFetch(data: data);
        });
  }

// BOTTOM MODAL SHEET FUNTION
  showModalSheet(messageID, email, message) async {
    final db = await FirebaseFirestore.instance
        .collection('Registry')
        .doc(currentUser?.email)
        .get();
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            height: 150,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 165),
                      child: Divider(
                        color: Theme.of(context).colorScheme.primary,
                        height: 5,
                        thickness: 1,
                      ),
                    ),
                  ),
                  // DELETE BUTTON
                  if (currentUser!.email?.toLowerCase() ==
                          email.toLowerCase() ||
                      db['isAdmin'] == true)
                    TextButton.icon(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          DeleteMessage(messageID);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary),
                        )),
                  // COPY BUTTON
                  TextButton.icon(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        copyFunction(message);
                      },
                      icon: Icon(Icons.copy,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary),
                      label: Text(
                        "Copy",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary),
                      ))
                ]),
          );
        });
  }

// DELETE NOTICE FUNCTION
  DeleteMessage(
    messageID,
  ) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Text(
                'Delete Notice',
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).colorScheme.primary),
              ),
              content: Text("Are you sure you want to delete this notice?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary)),
              actions: [
                TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary))),
                TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);

                      await FirebaseFirestore.instance
                          .collection('Notice')
                          .doc(messageID)
                          .delete()
                          .then((value) => showSnackBar("Notice Deleted!"))
                          .catchError((error) =>
                              showSnackBar("Failed to Delete: $error"));
                    },
                    child: Text("Yes",
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary))),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: _scrollDown,
        splashColor: Colors.transparent,
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      // APPBAR
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
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
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        maintainState: false,
                        builder: (context) => AddAnnounce()))
              },
              child: Text(
                "+ New",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            alignment: Alignment.center,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Theme.of(context).iconTheme.color,
            ),
            color: Colors.black,
            onPressed: () => {
              Navigator.pop(context),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()))
            },
          );
        }),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'NOTICE',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 30),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Notice")
              .orderBy("timestamp", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // MESSAGE VARIABLE
                  final post = snapshot.data!.docs[index];
                  // TIME VARIABLE
                  final rawDate = post["timestamp"].toDate();
                  final formatDate =
                      DateFormat('dd/MM/yyyy hh:mm a').format(rawDate);

                  return GestureDetector(
                    onLongPress: () {
                      showModalSheet(
                          post.id, post['userEmail'], post['message']);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(10)),
                        // EACH BOX PADDING
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        // BOX PADDING
                        padding: const EdgeInsets.only(
                            top: 10, left: 0, right: 0, bottom: 10),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Registry')
                                      .doc(post['userEmail'])
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      final userData = snapshot.data!.data()
                                          as Map<String, dynamic>;
                                      return Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Colors.black,
                                            backgroundImage: NetworkImage(userData[
                                                    'Avatar'] ??
                                                "https://media.discordapp.net/attachments/1173656243139788900/1173656309321715822/download.png?ex=6564bf9d&is=65524a9d&hm=829675fa6d28bedb531bc2dfc0ddf1dea83b398c1422c6928058ba5ed705b26a&="),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showProfileModal(
                                                      post['userEmail']);
                                                },
                                                child: Text(
                                                    userData['userName'] ??
                                                        "Error",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 20)),
                                              ),
                                              Text(formatDate,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return showSnackBar(
                                          'Error ${snapshot.error}');
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    );
                                  }),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                post['message'],
                                maxLines: 100000000,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return showSnackBar("Error: ${snapshot.error}");
            } else {
              Center(
                child: Text(
                  "X.X NO NOTICE",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
