import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/firebase_options.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/auth/auth_screen.dart';
import 'package:travelmatex/views/home/home_screen.dart';
import 'package:travelmatex/views/main_page/main_page.dart';
import 'package:travelmatex/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    sizeDefine(context);
    return GetMaterialApp(
      
      getPages: [
        GetPage(name: AppRoutes.main, page: () => MainScreen()),
        GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
        GetPage(
            name: AppRoutes.login,
            page: () => AuthenticationScreen(result: ValidationResults.loggin)),
        GetPage(
            name: AppRoutes.signUp,
            page: () => AuthenticationScreen(result: ValidationResults.newUser))
      ],
      debugShowCheckedModeBanner: false,
      title: 'TravelmateX',
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return const SplashScreen(result: ValidationResults.loggedIn);
            } else {
              return const SplashScreen(result: ValidationResults.newUser);
            }
          }),
    );
  }
}
