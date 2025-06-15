import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/features/add_category/widgets/custom_add_text_field.dart';
import 'package:firebase_test/features/auth/ui/widgets/custom_auth_button.dart';
import 'package:flutter/material.dart';

class UpdateCategory extends StatefulWidget {
  const UpdateCategory({super.key, required this.docId, required this.oldName});
  final String docId;
  final String oldName;
  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser() {
    return users.doc(widget.docId).update({'name': name.text});
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.oldName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Category")),
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
              title: "Save",
              onPressed: () {
                updateUser();
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
