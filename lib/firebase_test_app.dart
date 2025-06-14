import 'package:firebase_test/features/add_category/screens/add_category.dart';
import 'package:firebase_test/features/auth/ui/screens/login_screen.dart';
import 'package:firebase_test/features/auth/ui/screens/signup_screen.dart';
import 'package:firebase_test/features/home/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTestApp extends StatefulWidget {
  const FirebaseTestApp({super.key});

  @override
  State<FirebaseTestApp> createState() => _FirebaseTestAppState();
}

class _FirebaseTestAppState extends State<FirebaseTestApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('===User is currently signed out!===');
      } else {
        print('===User is signed in!===');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Test',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(size: 30, color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
          color: Colors.blue,
        ),
      ),

      // FirebaseAuth.instance.currentUser == null
      //     ? LoginScreen()
      //     : HomeScreen(),
      routes: {
        "signup": (context) => SignupScreen(),
        "login": (context) => LoginScreen(),
        "home": (context) => HomeScreen(),
        "addcategory": (context) => AddCategory(),
      },
    );
  }
}
