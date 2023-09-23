import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/services/auth_services.dart';
import 'package:rive/rive.dart';
import '../../utils/constants/constants.dart';
import '../widgets/text_form_fild_widget.dart';

final _formKey = GlobalKey<FormState>();

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key, required this.result});
  final ValidationResults result;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SizedBox(
                height: screenWidth * 0.95,
                width: double.infinity,
                child: Image.network(
                  "https://images.unsplash.com/photo-1539635278303-d4002c07eae3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fHw%3D&w=1000&q=80",
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.56,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        height10,
                        Text(
                          "Discover Kerala's beauty",
                          style: googleFontStyle(
                              fontsize: 30, fontweight: FontWeight.w600),
                        ),
                        Text(
                          result == ValidationResults.newUser
                              ? 'Join us'
                              : 'continue with login',
                          style: googleFontStyle(
                              fontsize: 18, fontweight: FontWeight.w400),
                        ),
                        result == ValidationResults.newUser
                            ? TextFieldWidget(
                                controller: nameController,
                                icon: Icons.account_circle_outlined,
                                hint: 'name')
                            : const SizedBox(),
                        height10,
                        TextFieldWidget(
                            controller: emailController,
                            icon: Icons.email_outlined,
                            hint: 'email'),
                        height10,
                        TextFieldWidget(
                          controller: passwordController,
                          icon: Icons.lock_outline,
                          hint: 'password',
                        ),
                        height20,
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate() ||
                                    passwordController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    result == ValidationResults.newUser
                                ? nameController.text.isEmpty
                                : emailController.text.isEmpty) {
                              Get.snackbar(
                                  'error', 'email and password is required',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.red,
                                  backgroundColor: Colors.white);
                            } else {
                              validation(result, context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.black,
                            fixedSize:
                                Size(screenWidth * 0.87, screenHeight * 0.06),
                          ),
                          child: Text(
                            result == ValidationResults.newUser
                                ? "Sign up"
                                : "Log in",
                            style: googleFontStyle(
                                fontsize: 18,
                                color: Colors.white,
                                fontweight: FontWeight.w500),
                          ),
                        ),
                        height10,
                        result == ValidationResults.newUser
                            ? const SizedBox()
                            : Text(
                                "Forgot password?",
                                style: googleFontStyle(
                                    fontsize: 15, fontweight: FontWeight.w400),
                              ),
                        height10,
                        ElevatedButton(
                          onPressed: () {
                            result == ValidationResults.newUser
                                ? Get.offNamed(AppRoutes.login)
                                : Get.offNamed(AppRoutes.signUp);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            fixedSize:
                                Size(screenWidth * 0.87, screenHeight * 0.06),
                          ),
                          child: Text(
                            result == ValidationResults.newUser
                                ? "Login"
                                : "Sign Up",
                            style: googleFontStyle(
                                fontsize: 18,
                                color: Colors.black,
                                fontweight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validation(ValidationResults result, BuildContext context) async {
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String email = emailController.text.trim();
    showDialog(
      context: context,
      builder: (context) {
        return const RiveAnimation.asset('assets/images/loading animation.riv');
      },
    );
    if (result == ValidationResults.newUser) {
      ValidationResults returnResult =
          await AuthServices.signupUser(name, email, password, context);
      validationResult(returnResult, result);
    } else {
      ValidationResults returnResult =
          await AuthServices.signIn(email, password, context);
      validationResult(returnResult, result);
    }
  }
}

validationResult(ValidationResults result, ValidationResults prevResult) {
  Get.back();
  if (result == ValidationResults.noInternetConnection) {
    Get.snackbar('wrong', 'check your connection',
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  } else if (result == ValidationResults.successfull) {
    if (prevResult == ValidationResults.newUser) {
      Get.snackbar('successfull', 'Registration Successfully',
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      Get.offNamedUntil(AppRoutes.login, (route) => false);
    } else {
      Get.snackbar('successfull', 'Login Successfully',
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      Get.offNamedUntil(AppRoutes.home, (route) => false);
    }
  } else if (result == ValidationResults.emailAlreadyInUse) {
    Get.snackbar('wrong', 'email already exist',
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  } else if (result == ValidationResults.userNotFound) {
    Get.snackbar('wrong', 'user not found',
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  } else if (result == ValidationResults.weakPassword) {
    Get.snackbar('wrong', 'weak password',
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  } else if (result == ValidationResults.wrongPassword) {
    Get.snackbar('wrong', 'wrong password',
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  } else {
    Get.snackbar('wrong', 'something went wrong',
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  }
}
