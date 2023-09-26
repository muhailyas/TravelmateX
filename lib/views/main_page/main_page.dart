import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/bottom_controller.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/views/slide_drawer/slide_drawer.dart';
import 'package:travelmatex/views/widgets/bottom_nav_widget/botton_nav_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final destinationController = Get.find<DestinationController>();
  final bottonController = Get.find<BottomBarController>();
  @override
  Widget build(BuildContext context) {
    destinationController.fetchDestinations();
    destinationController.fetchDestinationNearbyMe(null);
    return SafeArea(
        child: Scaffold(
      backgroundColor: backGroundColor,
      drawer: const SlideDrawer(),
      body: Obx(() => bottonController.pages[bottonController.index.value]),
      bottomNavigationBar: BottomNaviagationWidget(),
    ));
  }
}
