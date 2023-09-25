// form validation result Values

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

enum ValidationResults {
  successfull,
  noInternetConnection,
  weakPassword,
  emailAlreadyInUse,
  somethingWentWrong,
  userNotFound,
  wrongPassword,
  loggedIn,
  newUser,
  loggin
}

enum Network { hasNetwork, notAvailable }

// size difine function
double screenHeight = 0;
double screenWidth = 0;

void sizeDefine(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
}

// constant heights

final height10 = SizedBox(height: screenHeight * 0.02);
final height20 = SizedBox(height: screenHeight * 0.04);

// constant width

final width10 = SizedBox(width: screenWidth * 0.02);

// constant style

googleFontStyle(
    {Color color = Colors.black,
    double fontsize = 20,
    dynamic fontweight = FontWeight.w100,
    double letterSpacing = 0}) {
  return GoogleFonts.sourceSans3(
      color: color,
      fontSize: fontsize,
      fontWeight: fontweight,
      letterSpacing: letterSpacing);
}

// check connection

Future<Network> checkConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return Network.notAvailable;
  } else {
    return Network.hasNetwork;
  }
}

// show loading
void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const RiveAnimation.asset('assets/loading animation.riv');
    },
  );
}
