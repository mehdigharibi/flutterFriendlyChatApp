// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController coltroller;
  final IconData iconData;

  customTextField(
      {super.key,
      required this.obscureText,
      required this.hintText,
      required this.coltroller,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border:
              Border.all(color: Color.fromARGB(255, 216, 6, 221), width: 1)),
      child: TextField(
        controller: coltroller,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: hintText, icon: Icon(iconData)),
      ),
    );
  }
}
