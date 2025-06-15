import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/notes/screens/add_notes.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({super.key, required this.userId});
  final String userId;

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  // bool isLoading = true;

  List<QueryDocumentSnapshot> notes = [];

  getUsersData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('notes')
            .get();
    notes.addAll(querySnapshot.docs);
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNotes(userId: widget.userId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Notes'),
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
        itemCount: notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 160,
        ),
        itemBuilder: (context, i) {
          return Card(
            child: InkWell(
              onDoubleTap: () {},
              onLongPress: () {},
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(Icons.edit_document),
                    Spacer(),
                    Text(notes[i]['notes']),
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
