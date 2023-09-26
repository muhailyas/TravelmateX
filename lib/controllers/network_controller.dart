import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: Text(
            "Please check your internet connection",
            style: googleFontStyle(
                color: Colors.white, fontweight: FontWeight.w400),
          ),
          isDismissible: false,
          duration: const Duration(seconds: 10),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(Icons.wifi_off_rounded, color: whiteColor, size: 35),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
