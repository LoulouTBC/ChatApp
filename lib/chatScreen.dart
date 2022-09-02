import 'package:chat/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    final _auth = FirebaseAuth.instance;

  getContacts(){
    
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('hi'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          // color: Colors.amber,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: ListView(
          children: [
            // FutureBuilder(
            //   future: getContacts(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData) {
            //       return ListView.builder(itemCount: snapshot.data,)
            //     }
            // }),
            InkWell(
                onTap: () {},
                child: MyCard(ontap: () {}, title: 'loulou', subtitle: 'hi')),
          ],
        ),
        // child: ListView(
        //   children: [
        //     ...List.generate(
        //         4,
        //         (index) => Container(
        //               // padding: EdgeInsets.all(10),

        //               decoration: BoxDecoration(
        //                   border: Border(
        //                       bottom: BorderSide(
        //                           width: size.height * 0.002,
        //                           color: Colors.grey[400]!))),
        //               margin: EdgeInsets.only(
        //                   top: 10, bottom: 0, left: 10, right: 10),
        //               child: Material(
        //                 // color: Colors.pink,
        //                 child: InkWell(
        //                   // hoverColor: Colors.amber,
        //                   // focusColor: Colors.black,
        //                   splashColor: Colors.grey,
        //                   // highlightColor: Colors.amber,
        //                   // splashFactory: ,
        //                   onTap: (() {}),
        //                   child: Container(
        //                     // margin: EdgeInsets.symmetric(
        //                     //     horizontal: 10, vertical: 20),
        //                     width: 100,
        //                     height: 90,
        //                   ),
        //                 ),
        //               ),
        //             ))
        //   ],
        // ),
      ),
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