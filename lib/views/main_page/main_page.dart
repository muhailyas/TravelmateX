import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/bottom_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/views/slide_drawer/slide_drawer.dart';
import 'package:travelmatex/views/widgets/bottom_nav_widget/botton_nav_widget.dart';

final bottonController = Get.put(BottomBarController());

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backGroundColor,
      drawer: const SlideDrawer(),
      body: Obx(() => bottonController.pages[bottonController.index.value]),
      bottomNavigationBar: BottomNaviagationWidget(),
    ));
  }
}
