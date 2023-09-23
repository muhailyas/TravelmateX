import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices{
  static saveUser(String name, email, password, uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'name': name, 'email': email, 'Id': uid});
  }
}