import 'package:chat/chat.dart';
import 'package:chat/chatScreen.dart';
import 'package:chat/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  static const screenRoute = 'sign';

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formstate = new GlobalKey();
  ScrollController sc = new ScrollController();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String? myemail;
  String? mypassword;
  void scroll() {
    sc.position.maxScrollExtent;
  }

  signin() async {
    var formData = formstate.currentState;
    formData!.save();
    // setState(() {
    //   showSpinner = true;
    // });
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: myemail!,
        password: mypassword!,
      );
      if (user != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.screenRoute);

        // setState(() {
        //   showSpinner = false;
        // });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                      height: size.height * 0.72,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage('images/signBackground.png'))),
                      // height: size.height * 0.7,
                      // child: Image.asset(
                      //   'images/signBackground.png',
                      //   fit: BoxFit.cover,
                      // )
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.087),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // const SizedBox(
                          //   height: 50,
                          // ),
                          Container(
                            margin: EdgeInsets.only(
                                top: size.height * 0.2,
                                bottom: size.height * 0.22),
                            width: size.width * 0.2,
                            height: size.height * 0.25,
                            decoration: const BoxDecoration(
                                // color: Colors.red,
                                ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.12,
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

                          Container(
                            margin: EdgeInsets.only(
                                bottom: size.height * 0.02,
                                top: size.height * 0.08),
                            child: Form(
                              key: formstate,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,

                                    // textAlign: TextAlign.center,
                                    onSaved: (value) {
                                      myemail = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your Email',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.05,
                                          vertical: size.height * 0.02),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6155A6), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffFFABE1), width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  TextFormField(
                                    // textAlign: TextAlign.center,
                                    onSaved: (value) {
                                      mypassword = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.05,
                                          vertical: size.height * 0.02),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff6155A6), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffFFABE1), width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  MyButton(
                                      colortitle: Colors.white,
                                      color1: Color(0xff6155A6),
                                      color2:
                                          Color.fromARGB(255, 214, 201, 240),
                                      title: 'Sign In',
                                      onPressed: () async {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        var formData = formstate.currentState;
                                        formData!.save();

                                        try {
                                          final user = await _auth
                                              .signInWithEmailAndPassword(
                                                  email: myemail!,
                                                  password: mypassword!);
                                          if (user != null) {
                                            Navigator.pushReplacementNamed(
                                                context,
                                                ChatScreen.screenRoute);
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
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
