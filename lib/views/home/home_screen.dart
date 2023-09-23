import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/services/auth_services.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("home page"),
            IconButton(
                onPressed: () async {
                  ValidationResults result = await AuthServices.signoutUser();
                  if (result == ValidationResults.noInternetConnection) {
                    Get.snackbar(
                        'No connection', 'check your internet connection');
                  } else {
                    Get.offAllNamed(AppRoutes.login);
                  }
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
