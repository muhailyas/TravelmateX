import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class EditTileWidget extends StatelessWidget {
  EditTileWidget({super.key, required this.userDocRef});
  final DocumentReference userDocRef;

  final _formKey = GlobalKey<FormState>();
  final updateNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.edit, color: Colors.black),
      title: Text(
        "Edit name",
        style: googleFontStyle(fontsize: 18, fontweight: FontWeight.w400),
      ),
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return StreamBuilder<DocumentSnapshot>(
              stream: userDocRef.snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic>? data =
                      snapshot.data!.data() as Map<String, dynamic>?;
                  if (data != null) {
                    String name = data['name'];
                    updateNameController.text = name;
                  }
                }
                return AlertDialog(
                  title: Text(
                    'Edit name',
                    style: googleFontStyle(fontweight: FontWeight.w500),
                  ),
                  actions: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: updateNameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black),
                          child: Text(
                            'Cancel',
                            style: googleFontStyle(
                                fontsize: 16, fontweight: FontWeight.w400),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String updatedName =
                                  updateNameController.text;
                              updateNameInFirestore(updatedName);
                              Navigator.pop(context);
                            }
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black),
                          child: Text(
                            'Update',
                            style: googleFontStyle(
                                fontsize: 16, fontweight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void updateNameInFirestore(String updatedName) {
    final user = FirebaseAuth.instance.currentUser;
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    userDocRef.update({'name': updatedName}).then((_) {
      Get.snackbar('updated', 'name updated');
    }).catchError((error) {
      Get.snackbar('error', 'something went wrong');
    });
  }
}
