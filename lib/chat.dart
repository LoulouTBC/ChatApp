import 'package:chat/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser; //in all the file

class Chat extends StatefulWidget {
  final String recieverid;
  final String recievername;
  static const screenRoute = 'chat';

  const Chat({Key? key, required this.recieverid, required this.recievername})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final myController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  // late User signedInUser;
  String? message;
  String? mydata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
    // getMessages();
  }

  void getUsers() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        // print(user.uid);
        // FirebaseFirestore.instance.collection('users').
        // where('userid',isEqualTo: signedInUser.uid).get().
        // then((value) => value.docs.forEach((element){
        //   print (element.get('username'));
        // }));
        // mydata = await _fireStore
        //     .collection('users')
        //     .doc('${widget.recieverid}')
        //     .get()
        //     .then((value) => value.get('username'));
        // print(mydata);
        // print(signedInUser.email);

        // reciever =  _fireStore
        //     .collection('users')
        //     .where("userid", isEqualTo: widget.recieverid)
        //     .get()
        //     .then((value) => value.docs.forEach(
        //           (element) {
        //           element.get('sender');
        //           },
        //         ));
      }
    } catch (e) {
      print(e);
    }
  }

  addMessages() async {
    lastMessage = message;
    await _fireStore
        .collection('users')
        .doc("${signedInUser.uid}")
        .collection('others')
        .doc("${widget.recieverid}")
        .collection('messages')
        .add({
      'text': message,
      'senderid': signedInUser.uid,
      'recieverid': widget.recieverid,
      'time': FieldValue.serverTimestamp()
    });
    await _fireStore
        .collection('users')
        .doc("${widget.recieverid}")
        .collection('others')
        .doc("${signedInUser.uid}")
        .collection('messages')
        .add({
      'text': message,
      'senderid': signedInUser.uid,
      'recieverid': widget.recieverid,
      'time': FieldValue.serverTimestamp()
    });
  }

  String? lastMessage;
  // void getMessages() async {
    //   final messages = await _fireStore
    //       .collection('users')
    //       .doc('${signedInUser.uid}')
    //       .collection('others')
    //       .doc('QKfedPwY7CR44gML2hi54q8vQa53')
    //       .collection('messages')
    //       .get();
    //   // get return snapshot(copy of database at the moment)
    //   for (var message in messages.docs) {
    //     // for لأنو بدي كل رسالة لحال
    //     //
    //     print(message.data());
    //   }


  //   await _fireStore
  //       .collection('users')
  //       .doc("${signedInUser.uid}")
  //       .collection('others')
  //       .doc("${widget.recieverid}")
  //       .collection('messages')
  //       // .where('senderid', isEqualTo: signedInUser.uid)
  //       // .where('recieverid', isEqualTo: widget.recieverid)
  //       //بدي الرسائل تنعكس لما تصير سيندر وريسيفر
  //       .orderBy('time')
  //       .limitToLast(1)
  //       .get()
  //       .then(
  //     (value) {
  //       value.docs.forEach((element) {
  //         element.get('text');
  //       });
  //     },
  //   );
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
        backgroundColor: Color(0xff6155A6),
        title: Text('${widget.recievername}'),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, SignIn.screenRoute);
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

            StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('users')
                    .doc("${signedInUser.uid}")
                    .collection('others')
                    .doc("${widget.recieverid}")
                    .collection('messages')
                    // .where('senderid', isEqualTo: signedInUser.uid)
                    // .where('recieverid', isEqualTo: widget.recieverid)
                    //بدي الرسائل تنعكس لما تصير سيندر وريسيفر
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<MessageForm> messageWidgets = [];
                  if (snapshot.hasData) {
                    // ! اذا مافي داتا يعني
                    // add a spinner

                    final messages = snapshot.data!.docs
                        .reversed; //reversed to make new messages down
                    for (var message in messages) {
                      final messageText = message.get('text');
                      final messageSender = message.get('senderid');
                      final messagereciever = message.get('recieverid');
                      // final currentuser = signedInUser.email;

                      // if (currentuser == messageSender {
                      //   //the code of the message from the signed in user

                      // }

                      var messageWidget = MessageForm(
                        reciever: messagereciever,
                        text: messageText,
                        sender: messageSender,
                        isme: signedInUser.uid == messageSender, //if statement
                      );
                      messageWidgets.add(messageWidget);
                    }
                  }
                  // } else {
                  //   return const Center(
                  //     child: CircularProgressIndicator(backgroundColor: Colors.blue),
                  //   );
                  // }
                  return Expanded(
                    child: ListView(
                      reverse: true, //but new messages still at top
                      children: messageWidgets,
                    ),
                  );
                }),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: 'write your message here',
                          border: InputBorder.none),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await addMessages();
                      myController.clear();
                      // await _fireStore
                      //     .collection('users')
                      //     .doc("${signedInUser.uid}")
                      //     .collection('others')
                      //     .doc("${widget.recieverid}")
                      //     .collection('messages')
                      //     .add({
                      //   'text': message,
                      //   'senderid': signedInUser.uid,
                      //   'recieverid': widget.recieverid,
                      //   'time': FieldValue.serverTimestamp()
                      // });
                    },
                    child: const Text(
                      'send',
                      style: TextStyle(
                        color: Color(0xff6155A6),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageForm extends StatelessWidget {
  const MessageForm(
      {this.text,
      this.sender,
      required this.isme,
      required this.reciever,
      Key? key})
      : super(key: key);
  final bool isme;
  final String? sender;
  final String? reciever;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Text('$sender',
          //     style: TextStyle(
          //         fontSize: 12, color: Color.fromARGB(255, 245, 23, 97))),
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
            color: isme == true
                ? Color(0xff6155A6)
                : Color.fromARGB(255, 255, 255, 255),
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
