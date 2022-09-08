// ignore_for_file: sized_box_for_whitespace

import 'package:chat/chat.dart';
import 'package:chat/chatScreen.dart';
import 'package:chat/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance; //لتسجيل المستخمين

  String? myemail;
  String? myname;
  String? mypassword;
  bool showSpinner = false;
  GlobalKey<FormState> formstate = new GlobalKey();

  register() async {
    var formData = formstate.currentState;
    formData!.save();
    // async مشان مايكمل التطبيق شغلو قبل ما اعمل المصادقة

    // sync متزامنة بيحدثو سوا
    // async غير متزامنة متل المستقبل(future)

    // in try catch for errors
    setState(() {
      // لأنو تطبيق تفاعلي و statfl بتتغير حالته باستمرار
      showSpinner = true;
    });

    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: myemail!, password: mypassword!);
      Navigator.pushReplacementNamed(context, ChatScreen.screenRoute);
      setState(() {
        showSpinner = false;
      });
      CollectionReference usersref = _fireStore.collection('users');

      usersref.doc("${FirebaseAuth.instance.currentUser!.uid}").set({

        "username": "${myname}",
        "email": "${myemail}",
        "userid": "${FirebaseAuth.instance.currentUser!.uid}",
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //show dialog
        print(e);
      } else if (e.code == 'email-already-in-use') {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        width: size.width,
                        // height: size.height * 0.7,
                        child: Image.asset(
                          'images/signBackground.png',
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 43),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // const SizedBox(
                          //   height: 50,
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 140),
                            width: 100,
                            height: 200,
                            decoration: const BoxDecoration(
                                // color: Colors.red,
                                ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KaushanScript',
                                  ),
                                ),
                                // Text(
                                //   'for text messaging',
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 25,
                                //       fontWeight: FontWeight.bold,
                                //       fontFamily: 'Kalam',
                                //       letterSpacing: 2),
                                // )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.18,
                          ),
                          Form(
                            key: formstate,
                            child: Column(
                              children: [
                                TextFormField(
                                  onSaved: (newValue) {
                                    myname = newValue;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  // textAlign: TextAlign.center,

                                  decoration: const InputDecoration(
                                    hintText: 'Enter your Name',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff6155A6), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFFABE1), width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.004),
                                TextFormField(
                                  onSaved: (newValue) {
                                    myemail = newValue;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  // textAlign: TextAlign.center,

                                  decoration: const InputDecoration(
                                    hintText: 'Enter your Email',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff6155A6), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFFABE1), width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.004),
                                TextFormField(
                                  obscureText: true,
                                  // textAlign: TextAlign.center,
                                  onSaved: (value) {
                                    mypassword = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your Password',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff6155A6), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFFABE1), width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),
                          MyButton(
                              colortitle: Colors.white,
                              color1: Color(0xff6155A6),
                              color2: Color.fromARGB(255, 214, 201, 240),
                              title: 'Sign Up',
                              onPressed: () async {
                                await register();
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
