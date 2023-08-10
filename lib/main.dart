import 'package:ffriendlychat/firebase_options.dart';
import 'package:ffriendlychat/services/auth/auth_control.dart';
import 'package:ffriendlychat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Screens/intro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => AuthService(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 216, 6, 221),
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 216, 6, 221)),
          useMaterial3: false,
        ),
        home: introPage());
  }
}
