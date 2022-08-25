import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser; //in all the file

class Chat extends StatefulWidget {
  static const screenRoute = 'chat';

  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final myController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  // late User signedInUser;
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

  // void getMssages() async {
  //   final messages = await _fireStore.collection('messages').get();
  //   // get return snapshot(copy of database at the moment)
  //   for (var message in messages.docs) {
  //     // for لأنو بدي كل رسالة لحال
  //     //
  //     print(message.data());
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshot in _fireStore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

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
                // messageStream();
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
          // Container(),مشان المسافة وبطل بدي ياه
          MyStreamBuilder(),
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
                    controller: myController,
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
                    myController.clear();

                    _fireStore.collection('messages').add({
                      'text': message,
                      'sender': signedInUser.email,
                      'time': FieldValue.serverTimestamp()
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

class MyStreamBuilder extends StatelessWidget {
  const MyStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageForm> messageWidgets = [];
          if (snapshot.hasData) {
            // ! اذا مافي داتا يعني
            // add a spinner

            final messages = snapshot
                .data!.docs.reversed; //reversed to make new messages down
            for (var message in messages) {
              final messageText = message.get('text');
              final messageSender = message.get('sender');
              final currentuser = signedInUser.email;

              // if (currentuser == messageSender {
              //   //the code of the message from the signed in user

              // }
              final messageWidget = MessageForm(
                text: messageText,
                sender: messageSender,
                isme: currentuser == messageSender, //if statement
              );
              messageWidgets.add(messageWidget);
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.blue),
            );
          }
          return Expanded(
            child: ListView(
              reverse: true, //but new messages still at top
              children: messageWidgets,
            ),
          );
        });
  }
}

class MessageForm extends StatelessWidget {
  const MessageForm({this.text, this.sender, required this.isme, Key? key})
      : super(key: key);
  final bool isme;
  final String? sender;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',
              style: TextStyle(fontSize: 12, color: Colors.yellow[900])),
          Material(
            elevation: 5,
            borderRadius: isme == true
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
            color: isme == true ? Colors.blue[800] : Colors.white30,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15,
                    color: isme == true ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
