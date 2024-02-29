import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/services/auth_services.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class LogoutTileWidget extends StatelessWidget {
  const LogoutTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: Text(
        "Logout",
        style: googleFontStyle(
            fontsize: MediaQuery.of(context).textScaleFactor * 18,
            fontweight: FontWeight.w400),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure want to Logout'),
                  actions: [
                    TextButton.icon(
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(blackColor)),
                        onPressed: () async {
                          ValidationResults result =
                              await AuthServices.signoutUser();
                          if (result ==
                              ValidationResults.noInternetConnection) {
                            Get.snackbar(
                                'Network', 'Check your internet connection');
                          } else {
                            Get.offAllNamed(AppRoutes.login);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Yes')),
                    TextButton.icon(
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(blackColor)),
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                        label: const Text('No')),
                  ],
                ));
      },
    );
  }
}
