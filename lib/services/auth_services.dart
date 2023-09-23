import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'firestore_services.dart';

class AuthServices {
  static Future<ValidationResults> signupUser(
      String name, String email, String password, BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return ValidationResults.noInternetConnection;
    }
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FireStoreServices.saveUser(
          name, email, password, userCredential.user!.uid);
      return ValidationResults.successfull;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ValidationResults.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return ValidationResults.emailAlreadyInUse;
      }
    } catch (e) {
      return ValidationResults.somethingWentWrong;
    }
    return ValidationResults.somethingWentWrong;
  }

  static signinAdmin(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // Get.to(const ScreenAdmin());
    } on FirebaseAuthException catch (e) {
      if (e.code == '') {}
    }
  }

  static Future<ValidationResults> signIn(
      String email, String password, BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return ValidationResults.noInternetConnection;
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid == 'EQv2jxY4JtW94G8tNOxriloyRNt1'
          ? ValidationResults.successfull
          : ValidationResults.userNotFound;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ValidationResults.userNotFound;
      } else if (e.code == 'wrong-password') {
        return ValidationResults.wrongPassword;
      } else {
        return ValidationResults.somethingWentWrong;
      }
    }
  }

  static Future<ValidationResults> signoutUser(context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return ValidationResults.noInternetConnection;
    }
    await FirebaseAuth.instance.signOut();
    return ValidationResults.successfull;
  }
}
