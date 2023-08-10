import 'package:ffriendlychat/Screens/homePage.dart';
import 'package:ffriendlychat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/custom_Textfield.dart';
import '../Widgets/custom_button.dart';
import 'login_screen.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  void signUp() async {
    final authservice = Provider.of<AuthService>(context, listen: false);

    try {
      if (passwordController.text == confirmpasswordController.text) {
        await authservice
            .signUp(emailController.text, passwordController.text)
            .then((value) => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => homePage())));
      }
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create new account',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //Email textfield
                  customTextField(
                      obscureText: false,
                      hintText: 'Email',
                      coltroller: emailController,
                      iconData: Icons.email),
                  const SizedBox(
                    height: 10,
                  ),

                  //Password Textfield
                  customTextField(
                      obscureText: true,
                      hintText: 'Password',
                      coltroller: passwordController,
                      iconData: Icons.lock),
                  const SizedBox(
                    height: 10,
                  ),

                  //confirm Password
                  customTextField(
                      obscureText: true,
                      hintText: 'Confirm Password',
                      coltroller: confirmpasswordController,
                      iconData: Icons.lock),
                  //Signup button
                  const SizedBox(
                    height: 35,
                  ),
                  customButton(onTap: signUp, buttonText: 'Sign up'),

                  const SizedBox(
                    height: 30,
                  ),
                  //Not a Member ? register now

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already a member?'),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => loginScreen()));
                        },
                        child: Text(
                          'Login Now',
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
