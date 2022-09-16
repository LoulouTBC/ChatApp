import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {required this.color1,
      required this.color2,
      required this.title,
      required this.onPressed,
      required this.colortitle});

  final Color color1;
  final Color color2;
  final String title;
  final Color colortitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10),
    // child:
    return Container(
      width: size.width * 0.8,
      // padding: EdgeInsets.only(top: 5),
      // margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: new Offset(0, 0.8),
              blurRadius: 22.0,
            )
          ],
          gradient: LinearGradient(colors: [
            color1,
            color2,
          ])),
      // color: color,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          hoverColor: Colors.purple,
          focusColor: Colors.amber,
          onPressed: onPressed,
          // minWidth: size.width * 0.2,
          // height: 42,
          child: Text(
            title,
            style: TextStyle(color: colortitle, fontSize: size.width * 0.055),
          ),
        ),
      ),
    );
  }
}
