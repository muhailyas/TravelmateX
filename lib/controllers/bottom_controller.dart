import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travelmatex/views/explore/explore_screen.dart';
import 'package:travelmatex/views/favorite/favorite_screen.dart';
import 'package:travelmatex/views/home/home_screen.dart';
import 'package:travelmatex/views/trip/trip_plan_list/trip_plan_list.dart';

class BottomBarController extends GetxController {
  RxInt index = 0.obs;
  void indexChanger(int index) {
    this.index.value = index;
  }

  RxList<Widget> pages = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    ScreenTripPlans(),
    const FavoriteScreen(),
  ].obs;
}
