import 'package:flutter/material.dart';

class profileFetch extends StatelessWidget {
  final data;
  profileFetch({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      height: 400,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 165),
            child: Divider(
              color: Theme.of(context).colorScheme.primary,
              height: 5,
              thickness: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                '${data?['Avatar'] == null ? 'https://media.discordapp.net/attachments/1173656243139788900/1173656309321715822/download.png?ex=6564bf9d&is=65524a9d&hm=829675fa6d28bedb531bc2dfc0ddf1dea83b398c1422c6928058ba5ed705b26a&=' : data?['Avatar']}'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 8),
          child: Text(
            data?['userName'],
            style: TextStyle(
                fontSize: 30, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        if (data?['isAdmin'] == true)
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 2),
            child: Text(
              'Class Representative',
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              margin: const EdgeInsets.only(left: 15, top: 10),
              child: Center(
                child: Text(
                  'Roll: ${data?['Roll'] == null ? '' : data?['Roll']}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              margin: const EdgeInsets.only(left: 15, top: 10),
              child: Center(
                child: Text(
                  'Merit: ${data?['Merit'] == null ? '' : data?['Merit']}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            'About Me',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${data?['Bio'] == null ? '' : data?['Bio']}',
                style: TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
