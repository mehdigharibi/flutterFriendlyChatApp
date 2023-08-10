import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  customButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 216, 6, 221),
            borderRadius: BorderRadius.circular(9)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
