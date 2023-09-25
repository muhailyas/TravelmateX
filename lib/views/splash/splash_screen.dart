import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/splash/widgets/name_animation_widget/name_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.result});
  final ValidationResults result;

  validateLogin() async {
    Network networkAvailability = await checkConnection();
    if (networkAvailability == Network.notAvailable) {
      // add here route
    }
    await Future.delayed(const Duration(seconds: 1));
    if (result == ValidationResults.loggedIn) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    validateLogin();
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/splash.jpg'),
          fit: BoxFit.cover,
        )),
        child: const Scaffold(
          backgroundColor: transparentColor,
          body: FadeTextAnimation(),
        ),
      ),
    );
  }
}
