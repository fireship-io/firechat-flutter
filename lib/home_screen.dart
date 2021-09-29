import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/auth_provider.dart';
import 'package:firechat/bottom_chat_bar.dart';
import 'package:flutter/material.dart';
import 'package:firechat/loading.dart';
import 'package:firechat/styles.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user!.displayName!,
          style: appBarTheme,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Sign out',
              style: blackText,
            ),
            onPressed: () {
              AuthProvider().signOut();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User was signed out'),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Chats(),
            const BottomChatBar(),
          ],
        ),
      ),
    );
  }
}

class Chats extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _chatsStream = FirebaseFirestore.instance
      .collection('chats')
      .orderBy('createdAt', descending: false)
      .limit(15)
      .snapshots();

  Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('$snapshot.error'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        return Flexible(
          // Flexible prevents overflow error when keyboard is opened
          child: GestureDetector(
            // Close the keyboard if anything else is tapped
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map(
                (DocumentSnapshot doc) {
                  // Doc id
                  String id = doc.id;
                  // Chat data
                  Map<String, dynamic> data =
                      doc.data()! as Map<String, dynamic>;

                  // Chats sent by the current user
                  if (user?.uid == data['owner']) {
                    return SentMessage(data: data);
                  } else {
                    // Chats sent by everyone else
                    return ReceivedMessage(data: data);
                  }
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}

class SentMessage extends StatelessWidget {
  const SentMessage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(), // Dynamic width spacer
          Container(
            constraints: chatConstraints,
            padding: const EdgeInsets.only(
              left: 10.0,
              top: 5.0,
              bottom: 5.0,
              right: 5.0,
            ),
            decoration: const BoxDecoration(
              gradient: sent,
              borderRadius: round,
            ),
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      data['text'],
                      textAlign: TextAlign.right,
                      style: chatText,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      data['imageUrl'],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: chatConstraints,
            padding: const EdgeInsets.only(
              left: 5.0,
              top: 5.0,
              bottom: 5.0,
              right: 10.0,
            ),
            decoration: const BoxDecoration(
              gradient: received,
              borderRadius: round,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    data['imageUrl'],
                  ),
                ),
                const SizedBox(width: 10.0),
                Flexible(
                  child: Text(
                    data['text'],
                    textAlign: TextAlign.left,
                    style: chatText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(), // Dynamic width spacer
        ],
      ),
    );
  }
}
