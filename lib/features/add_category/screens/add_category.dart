import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/features/add_category/widgets/custom_add_text_field.dart';
import 'package:firebase_test/features/auth/ui/widgets/custom_auth_button.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'name': name.text, // John Doe
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: CustomTextFormAdd(
                hinttext: "Enter Name",
                mycontroller: name,
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
                addUser();
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
