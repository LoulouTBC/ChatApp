import 'package:chat/regist.dart';
import 'package:chat/signin.dart';
import 'package:flutter/material.dart';
import 'package:chat/my_button.dart';

class Welcome extends StatefulWidget {
  static const String screenRoute =
      'welcome'; //static const مشان ما انشئ كامل الكلاس ويبطئ التطبيق
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/1.png'),
                ),
                const Text(
                  'Message',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 15, 22, 129)),
                )
              ],
            ),
            const SizedBox(height: 30),
            MyButton(
              color: Colors.blue[900]!,
              title: 'Sign In',
              onPressed: () {
                Navigator.pushNamed(context, SignIn.screenRoute);
              },
            ),
            MyButton(
                color: Colors.green[700]!,
                title: 'register',
                onPressed: () {
                  Navigator.pushNamed(context, Register.screenRoute);
                })
          ],
        ),
      ),
    );
  }
}
