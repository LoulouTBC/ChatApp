import 'package:chat/card.dart';
import 'package:chat/chat.dart';
import 'package:chat/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = "chatScreen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    // lastMessage= getMessages('KB8BnqN3Xma62VCrnKtpZvxqVEm2').toString();
  }

  late String lastMessage;
  getMessages(recieverid)  {
    late String lastMessage;
    final m =  _fireStore
        .collection('users')
        .doc(signedInUser.uid)
        .collection('others')
        .doc(recieverid)
        .collection('messages')
        .snapshots()
        .listen((event) {
      return event.docs.first.get('text');
    });

    

    // return (lastMessage);
    // var messages =  _fireStore
    //     .collection('users')
    //     .doc(signedInUser.uid)
    //     .collection('others')
    //     .doc(recieverid)
    //     .collection('messages')
    //     .orderBy('time', descending: true)
    //     .limit(1)
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     // print('=====================================');
    //     // print(element.get('text'));
    //     lastMessage = element.get('text').toString();
    //   });
    // });
    // // print("=======================");
    // // print("==================================");
    // // print(lastMessage);
    // return lastMessage;
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        // print(signedInUser.email);

      }
    } catch (e) {
      print(e);
    }
  }

  final _auth = FirebaseAuth.instance;

  getContacts() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('hi'),
        elevation: 0,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection('users')
            .where('userid', isNotEqualTo: signedInUser.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  return MyCard(
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Chat(
                                recieverid:
                                    "${snapshot.data!.docs[i].get('userid')}",
                                recievername:
                                    "${snapshot.data!.docs[i].get('username')}")));
                        // Chat(recieverid: "${snapshot.data!.docs[i].get('userid')}");
                      },
                      title: '${snapshot.data!.docs[i].get('username')}',
                      subtitle:  lastMessage);
                });
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
