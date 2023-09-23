import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/bottom_controller.dart';
import 'package:travelmatex/views/widgets/bottom_nav_widget/botton_nav_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final bottonController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(() => bottonController.pages[bottonController.index.value]),
      bottomNavigationBar: BottomNaviagationWidget(),
    ));
  }
}
