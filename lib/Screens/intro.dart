import 'package:ffriendlychat/services/auth/auth_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

import 'login_screen.dart';

class introPage extends StatefulWidget {
  const introPage({super.key});

  @override
  State<introPage> createState() => _introPageState();
}

class _introPageState extends State<introPage> with TickerProviderStateMixin {
  late FlutterGifController controller1;
  @override
  void initState() {
    super.initState();
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller1.repeat(
        min: 0,
        max: 95,
        period: const Duration(milliseconds: 3000),
      );
    });

//Goto AuthController
    Future.delayed(Duration(milliseconds: 3300)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => AuthGate())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: GifImage(
          controller: controller1,
          image: const AssetImage("assets/images/intro.gif"),
        ),
      ),
    );
  }
}
