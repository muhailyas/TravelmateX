import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/explore/widgets/destination_card/destination_card_widget.dart';
import '../detail/detail_screen.dart';

class CategoryListScreen extends StatelessWidget {
  CategoryListScreen({super.key});
  final filterController = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String category = arguments['argument1'];
    filterController.getDestinationByCategory(category);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: backGroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          category,
          style: googleFontStyle(fontweight: FontWeight.w400, fontsize: 22),
        ),
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, value) {
            if (value.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Obx(() {
              if (filterController.destinationByCateogryList.isEmpty) {
                return const Center(
                  child: Text("Not found"),
                );
              }
              return ListView.builder(
                itemCount: filterController.destinationByCateogryList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(const DetailScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 500),
                          arguments: {
                            'destination': filterController.filteredList[index]
                          });
                    },
                    child: DestinationCardExplore(
                        filterController: filterController, index: index),
                  );
                },
              );
            });
          }),
    );
  }
}
