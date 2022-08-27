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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'images/welcome.png',
                fit: BoxFit.fill,

                // alignment: Alignment.centerRight,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 180,
                  //       child: Image.asset('images/1.png'),
                  //     ),
                  //     const Text(
                  //       'Message',
                  //       style: TextStyle(
                  //           fontSize: 40,
                  //           fontWeight: FontWeight.w900,
                  //           color: Color.fromARGB(255, 15, 22, 129)),
                  //     )
                  //   ],
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
                          'L-CHAT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KaushanScript',
                          ),
                        ),
                        Text(
                          'for text messaging',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kalam',
                              letterSpacing: 2),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyButton(
                          colortitle: Color.fromARGB(255, 96, 31, 180),
                          color1: Color(0xffA685E2),
                          color2: Color(0xffFFE6E6),
                          title: 'Sign In',
                          onPressed: () {
                            Navigator.pushNamed(context, SignIn.screenRoute);
                          }),
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Create new account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Register.screenRoute);
                              },
                              child: const Text(
                                'Sign Up!',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 96, 31, 180),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // MyButton(
                      //     colortitle: Colors.white,
                      //     color1: Color.fromARGB(255, 77, 19, 145),
                      //     color2: Color.fromARGB(255, 184, 138, 221),
                      //     title: 'register',
                      //     onPressed: () {
                      //       Navigator.pushNamed(
                      //           context, Register.screenRoute);
                      //     }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
