import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/utils/constants/constants.dart';

validationResult(ValidationResults result, ValidationResults prevResult) {
  Get.back();
  if (result == ValidationResults.noInternetConnection) {
    Get.snackbar('wrong', 'check your connection', backgroundColor: Colors.red);
  } else if (result == ValidationResults.successfull) {
    if (prevResult == ValidationResults.newUser) {
      Get.snackbar('successfull', 'Registration Successfully',
          backgroundColor: Colors.green);
      Get.offNamedUntil(AppRoutes.login, (route) => false);
    } else {
      Get.snackbar('successfull', 'Login Successfully',
          backgroundColor: Colors.green);
      Get.offNamedUntil(AppRoutes.main, (route) => false);
    }
  } else if (result == ValidationResults.emailAlreadyInUse) {
    Get.snackbar('wrong', 'email already exist', backgroundColor: Colors.red);
  } else if (result == ValidationResults.userNotFound) {
    Get.snackbar('wrong', 'user not found', backgroundColor: Colors.red);
  } else if (result == ValidationResults.weakPassword) {
    Get.snackbar('wrong', 'weak password', backgroundColor: Colors.red);
  } else if (result == ValidationResults.wrongPassword) {
    Get.snackbar('wrong', 'wrong password', backgroundColor: Colors.red);
  } else {
    Get.snackbar('wrong', 'something went wrong', backgroundColor: Colors.red);
  }
}