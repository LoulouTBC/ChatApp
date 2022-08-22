import 'package:chat/chat.dart';
import 'package:chat/regist.dart';
import 'package:chat/signin.dart';
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my chat app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Register(),
      initialRoute: Welcome.screenRoute,
      routes: {
        Welcome.screenRoute: (context) => const Welcome(),
        SignIn.screenRoute: (context) => const SignIn(),
        Register.screenRoute: (context) => const Register(),
        Chat.screenRoute: (context) => const Chat(),
      },
    );
  }
}
