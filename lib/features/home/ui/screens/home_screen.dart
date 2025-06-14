import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).pushNamed("addcategory");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Homepage'),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      // body:
      //     isLoading == true
      //         ? Center(child: CircularProgressIndicator())
      //         : GridView.builder(
      //           itemCount: 3,
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2,
      //             mainAxisExtent: 160,
      //           ),
      //           itemBuilder: (context, i) {
      //             return Card(
      //               child: Container(
      //                 padding: EdgeInsets.all(10),
      //                 child: Column(
      //                   children: [Icon(Icons.edit_document), Text("name")],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
    );
  }
}
