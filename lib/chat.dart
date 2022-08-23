import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  static const screenRoute = 'chat';

  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(children: [
          Image.asset(
            'images/1.png',
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('message me'),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, //مشان ينزل حسب المسافة لتحت
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.orange, width: 2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      message = value;
                    },
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: 'write your message here',
                        border: InputBorder.none),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _fireStore.collection('messages').add({
                      'text': message,
                      'sender': signedInUser.email,
                    });
                  },
                  child: Text(
                    'send',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
