import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/auth_provider.dart';
import 'package:firechat/bottom_chat_bar.dart';
import 'package:firechat/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firechat/styles.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
          Builder(
            builder: (BuildContext context) {
              return TextButton(
                child: const Text(
                  'Sign out',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  final provider = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );
                  provider.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User was signed out!'),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Chats(),
            BottomChatBar(),
          ],
        ),
      ),
    );
  }
}

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _chatsStream = FirebaseFirestore.instance
      .collection('chats')
      .orderBy('createdAt', descending: false)
      .limit(25)
      .snapshots();

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
          child: GestureDetector(
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
                  // Get both data and the doc Id
                  Map<String, dynamic> data =
                      doc.data()! as Map<String, dynamic>;
                  String id = doc.id; // Id

                  if (user?.uid == data['owner']) {
                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 310.0),
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 4.0,
                              bottom: 4.0,
                              right: 4.0,
                            ),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.orangeAccent]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            child: GestureDetector(
                              onTap: () => deleteMessage(id),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      data['text'],
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage(data['imageUrl']),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 310.0),
                            padding: const EdgeInsets.only(
                              left: 5.0,
                              top: 5.0,
                              bottom: 5.0,
                              right: 10.0,
                            ),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.lightBlue,
                                Colors.lightBlueAccent
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(data['imageUrl']),
                                ),
                                const SizedBox(width: 10.0),
                                Flexible(
                                  child: Text(
                                    data['text'],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    );
                  }
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }

  void deleteMessage(id) async {
    if (id == null) {
      return;
    } else {
      try {
        await FirebaseFirestore.instance
            .collection("chats")
            .doc(id)
            .delete()
            .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Message deleted',
                  ),
                  duration: Duration(
                    seconds: 3,
                  ),
                ),
              ),
            );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$e',
            ),
            duration: const Duration(
              seconds: 3,
            ),
          ),
        );
      }
    }
  }
}
