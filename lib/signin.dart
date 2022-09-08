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
  ScrollController sc = new ScrollController();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  void scroll(){
    sc.position.maxScrollExtent;
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
        child: ListView(children: [
          Column(
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
                          margin: EdgeInsets.only(top: size.height * 0.18),
                          width: 100,
                          height: 200,
                          decoration: const BoxDecoration(
                              // color: Colors.red,
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Sign In',
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
                          height: size.height * 0.23,
                        ),
                        Container(
                          child: Column(
                            children: [
                              TextField(
                                scrollController: sc,
                                
                                keyboardType: TextInputType.emailAddress,

                                // textAlign: TextAlign.center,
                                onChanged: (value) {
                                  email = value;
                                },
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
                              SizedBox(height: 6),
                        TextField(
                          obscureText: true,
                          // textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
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
                         SizedBox(
                          height: size.height*0.05,
                        ),
                        MyButton(
                            colortitle: Colors.white,
                            color1: Color(0xff6155A6),
                            color2: Color.fromARGB(255, 214, 201, 240),
                            title: 'Sign In',
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.pushReplacementNamed(
                                      context, ChatScreen.screenRoute);
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
                        
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
