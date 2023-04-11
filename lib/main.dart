import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/mobile_screen_layout.dart';
import 'package:flutter_application_1/responsive/responsive_screen_layout.dart';
import 'package:flutter_application_1/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/donate_page.dart';
import 'package:flutter_application_1/screens/login_screeen.dart';
import 'package:flutter_application_1/screens/main_landing_page.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedF0rk App',
      theme: ThemeData.light(),
      home: LoginScreen(),
    );
  }
}
