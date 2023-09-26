import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/dependency_injection.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';

validationResult(ValidationResults result, ValidationResults prevResult) {
  final favoriteController = Get.put(FavoriteController());
  Get.back();
  if (result == ValidationResults.noInternetConnection) {
    Get.rawSnackbar(
        messageText: Text('check your connection',
            style: googleFontStyle(
                fontsize: 17, fontweight: FontWeight.w400, color: whiteColor)),
        backgroundColor: Colors.red);
  } else if (result == ValidationResults.successfull) {
    if (prevResult == ValidationResults.newUser) {
      Get.rawSnackbar(
          messageText: Text('Registration Successfully',
              style: googleFontStyle(
                  fontsize: 17,
                  fontweight: FontWeight.w400,
                  color: whiteColor)),
          backgroundColor: Colors.green);
      Get.offAllNamed(AppRoutes.login);
    } else {
      DependencyInjection.onInit();
      Get.offAllNamed(AppRoutes.main);
      Get.rawSnackbar(
          messageText: Text('Login Successfully',
              style: googleFontStyle(
                  fontsize: 17,
                  fontweight: FontWeight.w400,
                  color: whiteColor)),
          backgroundColor: Colors.green);
      favoriteController.initFavorites();
    }
  } else if (result == ValidationResults.emailAlreadyInUse) {
    Get.rawSnackbar(
        messageText: Text('email already exist',
            style: googleFontStyle(
                fontsize: 17, fontweight: FontWeight.w400, color: whiteColor)),
        backgroundColor: Colors.red);
  } else if (result == ValidationResults.userNotFound) {
    Get.rawSnackbar(
        messageText: Text('user not found',
            style: googleFontStyle(
                fontsize: 17, fontweight: FontWeight.w400, color: whiteColor)),
        backgroundColor: Colors.red);
  } else if (result == ValidationResults.weakPassword) {
    Get.rawSnackbar(
        messageText: Text('weak password',
            style: googleFontStyle(
                fontsize: 17, fontweight: FontWeight.w400, color: whiteColor)),
        backgroundColor: Colors.red);
  } else if (result == ValidationResults.wrongPassword) {
    Get.rawSnackbar(
        messageText: Text('wrong password',
            style: googleFontStyle(
                fontsize: 17, fontweight: FontWeight.w400, color: whiteColor)),
        backgroundColor: Colors.red);
  } else {
    Get.rawSnackbar(
        messageText: Text('something went wrong',
            style: googleFontStyle(fontsize: 17, fontweight: FontWeight.w400)),
        backgroundColor: Colors.red);
  }
}
