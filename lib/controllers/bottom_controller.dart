import 'package:get/get.dart';
import 'package:travelmatex/views/explore/explore_screen.dart';
import 'package:travelmatex/views/favorite/favorite_screen.dart';
import 'package:travelmatex/views/home/home_screen.dart';
import 'package:travelmatex/views/trip_plan/trip_plan_screen.dart';

class BottomBarController extends GetxController {
  RxInt index = 0.obs;
  void indexChanger(int index) {
    this.index.value = index;
  }

  RxList pages = [
     HomeScreen(),
     ExploreScreen(),
    const TripPlansScreen(),
     FavoriteScreen(),
  ].obs;
}
