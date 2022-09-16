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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/welcome2.png'),
                          fit: BoxFit.fill)),
                  // child: Image.asset(
                  //   'images/welcome2.png',
                  //   fit: BoxFit.fill,

                  //   // alignment: Alignment.centerRight,
                  // ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
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
                        margin: EdgeInsets.only(top: size.width * 0.34),
                        width: size.width,
                        height: size.height * 0.32,
                        // decoration: const BoxDecoration(
                        //   color: Colors.red,
                        // ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LightChat',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KaushanScript',
                              ),
                            ),
                            Text(
                              'for text messaging',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.065,
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
                              colortitle:
                                  const Color.fromARGB(255, 96, 31, 180),
                              color1: const Color(0xffA685E2),
                              color2: const Color(0xffFFE6E6),
                              title: 'Sign In',
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignIn.screenRoute);
                              }),
                          SizedBox(
                            height: size.height * 0.15,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Don't have an account?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                // SizedBox(
                                //   width: size.height * 0.004,
                                // ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Register.screenRoute);
                                    },
                                    child: Text(
                                      'Create one!',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 96, 31, 180),
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w700,
                                          fontSize: size.width * 0.043),
                                    ),
                                  ),
                                ),
                              ],
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
