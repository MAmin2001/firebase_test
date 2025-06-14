import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/auth/ui/widgets/custom_auth_button.dart';
import 'package:firebase_test/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // print('Google sign in aborted');
      return;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    if (userCredential.user == null) {
      print('no sign in ');
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                Container(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(height: 10),
                const Text(
                  "Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(height: 20),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Email",
                  mycontroller: email,
                ),
                Container(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: password,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            CustomButtonAuth(
              title: "login",
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                  Navigator.of(context).pushReplacementNamed('home');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
            ),
            Container(height: 20),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () {
                signInWithGoogle();
              },
              child: const Text("Login With Google  "),
            ),
            Container(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("signup");
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Don't Have An Account ? "),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
