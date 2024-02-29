import 'package:get/get.dart';
import 'package:travelmatex/controllers/bottom_controller.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/controllers/network_controller.dart';
import 'package:travelmatex/controllers/search_controller.dart';
import 'package:travelmatex/controllers/trip_plan_controller.dart';

class DependencyInjection {
  static onInit() {
    Get.put(() => NetworkController());
    Get.lazyPut(() => BottomBarController());
    Get.lazyPut(() => SearchControllerHome());
    Get.lazyPut(() => FilterController());
    Get.lazyPut(() => FavoriteController());
    Get.lazyPut(() => DestinationController());
    Get.lazyPut(() => TripPlanController());
  }
}
