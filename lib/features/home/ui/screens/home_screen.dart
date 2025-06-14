import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<QueryDocumentSnapshot> usersData = [];

  getUsersData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    usersData.addAll(querySnapshot.docs);
    setState(() {});
  }

  deleteUserData({required int index}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(usersData[index].id)
        .delete();
    usersData.clear(); // Clear the old list
    await getUsersData();
    setState(() {});
  }

  @override
  void initState() {
    getUsersData();
    super.initState();
  }

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
      body: GridView.builder(
        itemCount: usersData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 160,
        ),
        itemBuilder: (context, i) {
          return Card(
            child: InkWell(
              onLongPress: () {
                deleteUserData(index: i);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(Icons.edit_document),
                    Spacer(),
                    Text(usersData[i]['name']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
