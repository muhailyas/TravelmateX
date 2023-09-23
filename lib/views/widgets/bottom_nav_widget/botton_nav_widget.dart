import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/bottom_controller.dart';

class BottomNaviagationWidget extends StatelessWidget {
  BottomNaviagationWidget({super.key});
  final bottomController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FlashyTabBar(
        selectedIndex: bottomController.index.value,
        items: [
          FlashyTabBarItem(
              icon: const Icon(Icons.home_rounded), title: const Text('Home')),
          FlashyTabBarItem(
              icon: const Icon(Icons.explore), title: const Text('Explore')),
          FlashyTabBarItem(
              icon: const Icon(Icons.search), title: const Text('Search')),
          FlashyTabBarItem(
              icon: const Icon(Icons.flight_takeoff),
              title: const Text('Trip plan')),
          FlashyTabBarItem(
              icon: const Icon(Icons.favorite_border_outlined),
              title: const Text('Favorites')),
        ],
        onItemSelected: (value) {
          bottomController.indexChanger(value);
        },
      );
    });
  }
}
