import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/styles.dart';
import 'package:flutter/material.dart';

class BottomChatBar extends StatefulWidget {
  const BottomChatBar({Key? key}) : super(key: key);

  @override
  _BottomChatBarState createState() => _BottomChatBarState();
}

class _BottomChatBarState extends State<BottomChatBar> {
  final textController = TextEditingController();

  @override
  // Clean up on destroy
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser;
  CollectionReference chatsRef = FirebaseFirestore.instance.collection("chats");

  Future sendMessage() async {
    if (textController.text.isNotEmpty) {
      if (textController.text.length < 40) {
        try {
          return chatsRef.doc().set(
            {
              "text": textController.text,
              "owner": user?.uid,
              "imageUrl": user?.photoURL,
              "createdAt": FieldValue.serverTimestamp(),
            },
          ).then(
            (value) => {
              textController.clear(),
            },
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$e'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Must be 40 characters or less'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Chat can't be empty"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff161616),
        boxShadow: [boxShadow],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              constraints: const BoxConstraints(
                maxWidth: 275,
              ),
              child: TextField(
                cursorColor: Colors.lightBlue,
                controller: textController,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                style: inputText,
                keyboardType: TextInputType.text,
                onEditingComplete: sendMessage,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xff212121),
                  border: outlineBorder,
                  enabledBorder: roundedBorder,
                  labelStyle: placeholder,
                  labelText: 'Enter message',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.only(
                    left: 20.0,
                    right: 10.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45,
              width: 50,
              child: FloatingActionButton(
                onPressed: sendMessage,
                elevation: 8.0,
                backgroundColor: Colors.lightBlue,
                child: const Center(
                  child: Icon(
                    Icons.send,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
