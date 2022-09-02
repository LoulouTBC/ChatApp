import 'package:chat/chat.dart';
import 'package:chat/chatScreen.dart';
import 'package:chat/regist.dart';
import 'package:chat/signin.dart';
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my chat app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Register(),
      initialRoute:
          _auth.currentUser != null ? Chat.screenRoute : ChatScreen.screenRoute,
      routes: {
        Welcome.screenRoute: (context) => const Welcome(),
        SignIn.screenRoute: (context) => const SignIn(),
        Register.screenRoute: (context) => const Register(),
        Chat.screenRoute: (context) => const Chat(),
        ChatScreen.screenRoute: (context) => const ChatScreen(),
      },
    );
  }
}
