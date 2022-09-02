import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final String subtitle;
  const MyCard(
      {Key? key,
      required this.ontap,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  'images/1.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 4,
                child: ListTile(
                  title: Text("$title"),
                  subtitle: Text('$subtitle'),
                ))
          ],
        ),
      ),
    );
  }
}
