// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BottomChatBar extends StatefulWidget {
  const BottomChatBar({Key? key}) : super(key: key);

  @override
  _BottomChatBarState createState() => _BottomChatBarState();
}

class _BottomChatBarState extends State<BottomChatBar> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser;
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");

  Future sendMessage() async {
    if (myController.text.isNotEmpty) {
      if (myController.text.length < 40) {
        try {
          return chats.doc().set(
            {
              "text": myController.text,
              "owner": user?.uid,
              "imageUrl": user?.photoURL,
              "createdAt": FieldValue.serverTimestamp(),
            },
          ).then(
            (value) => myController.clear(),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e')),
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
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.0,
            blurRadius: 0.0,
            color: Colors.black12,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              constraints: const BoxConstraints(maxWidth: 275),
              child: TextField(
                cursorColor: Colors.lightBlue,
                controller: myController,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
                keyboardType: TextInputType.text,
                onEditingComplete: sendMessage,
                decoration: const InputDecoration(
                  isDense: false,
                  filled: true,
                  fillColor: Color(0xff212121),
                  contentPadding: EdgeInsets.only(
                    left: 20.0,
                    right: 10.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'Enter message',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
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
