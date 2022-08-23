// ignore_for_file: sized_box_for_whitespace

import 'package:chat/chat.dart';
import 'package:chat/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  static const screenRoute = 'register';
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance; //لتسجيل المستخمين

  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 180,
                    child: Image.asset('images/1.png'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    // textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    // textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyButton(
                      color: Colors.blue[800]!,
                      title: 'Register',
                      onPressed: () async {
                        // async مشان مايكمل التطبيق شغلو قبل ما اعمل المصادقة

                        // sync متزامنة بيحدثو سوا
                        // async غير متزامنة متل المستقبل(future)

                        // in try catch for errors
                        setState(() {
                          // لأنو تطبيق تفاعلي و statfl بتتغير حالته باستمرار
                          showSpinner = true;
                        });

                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          Navigator.pushNamed(context, Chat.screenRoute);
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
