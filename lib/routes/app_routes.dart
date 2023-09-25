import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/about/about_screen.dart';
import 'package:travelmatex/views/auth/auth_screen.dart';
import 'package:travelmatex/views/category_list/category_list_screen.dart';
import 'package:travelmatex/views/home/home_screen.dart';
import 'package:travelmatex/views/main_page/main_page.dart';

class AppRoutes {
  static String main = '/main';
  static String home = '/home';
  static String splash = '/splash';
  static String login = '/login';
  static String signUp = '/signUp';
  static String about = '/about';
  static String categoryList = '/categoryList';

  static List<GetPage<dynamic>>? getPages = [
    GetPage(name: AppRoutes.main, page: () => MainScreen()),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(name: AppRoutes.about, page: () => const AboutScreen()),
    GetPage(name: AppRoutes.categoryList, page: () => CategoryListScreen()),
    GetPage(
        name: AppRoutes.login,
        page: () => AuthenticationScreen(result: ValidationResults.loggin)),
    GetPage(
        name: AppRoutes.signUp,
        page: () => AuthenticationScreen(result: ValidationResults.newUser)),
  ];
}
