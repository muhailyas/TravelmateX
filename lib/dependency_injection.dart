import 'package:get/get.dart';
import 'package:travelmatex/controllers/bottom_controller.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/controllers/network_controller.dart';
import 'package:travelmatex/controllers/search_controller.dart';
class DependencyInjection {
  static onInit() {
    Get.lazyPut(() => BottomBarController());
    Get.lazyPut(() => SearchControllerHome());
    Get.lazyPut(() => NetworkController());
    Get.lazyPut(() => FilterController());
    Get.lazyPut(() => FavoriteController());
    Get.lazyPut(() => DestinationController());
  }
}

