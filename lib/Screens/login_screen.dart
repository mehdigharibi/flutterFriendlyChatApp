// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ffriendlychat/Screens/register_screen.dart';
import 'package:ffriendlychat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/custom_Textfield.dart';
import '../Widgets/custom_button.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn() {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      authService.signInWithEP(emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Logo
                  Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Image.asset('assets/images/logo.png')),
                  // Welcome Back Message
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome Back You\'ve been missed!',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //Email textfield
                  customTextField(
                      obscureText: false,
                      hintText: 'Email',
                      coltroller: emailController,
                      iconData: Icons.email),
                  SizedBox(
                    height: 10,
                  ),

                  //Password Textfield
                  customTextField(
                      obscureText: true,
                      hintText: 'Password',
                      coltroller: passwordController,
                      iconData: Icons.lock),
                  //Signin button
                  SizedBox(
                    height: 35,
                  ),
                  customButton(onTap: signIn, buttonText: 'Sign in'),

                  SizedBox(
                    height: 30,
                  ),
                  //Not a Member ? register now

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?'),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => registerScreen()));
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
