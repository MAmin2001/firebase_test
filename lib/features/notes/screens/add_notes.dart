import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/features/add_category/widgets/custom_add_text_field.dart';
import 'package:firebase_test/features/auth/ui/widgets/custom_auth_button.dart';
import 'package:firebase_test/features/notes/screens/view_notes.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key, required this.userId});
  final String userId;
  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();

  Future<void> addNote() {
    CollectionReference notes = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('notes');
    return notes
        .add({
          'notes': note.text, // John Doe
        })
        .then((value) => print("note Added"))
        .catchError((error) => print("Failed to add note: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Notes")),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: CustomTextFormAdd(
                hinttext: "Enter Note Here",
                mycontroller: note,
                validator: (val) {
                  if (val == "") {
                    return "Can't To be Empty";
                  }
                },
              ),
            ),
            CustomButtonAuth(
              title: "Add",
              onPressed: () {
                addNote();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNotes(userId: widget.userId),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
