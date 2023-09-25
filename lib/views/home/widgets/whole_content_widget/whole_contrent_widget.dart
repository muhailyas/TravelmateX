import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/home/widgets/category_row_widget/category_row_widget.dart';
import 'package:travelmatex/views/home/widgets/destination_card_widget/destination_card_widget.dart';
import 'package:travelmatex/views/home/widgets/destination_tile_widget.dart/destination_tile_widget.dart';
import 'package:travelmatex/views/main_page/main_page.dart';

class WholeContentWidget extends StatelessWidget {
  WholeContentWidget({
    super.key,
  });
  final destinationController = Get.find<DestinationController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CategoryRowWidget(),
        height10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Popular Destination",
                  style: googleFontStyle(
                      fontweight: FontWeight.w600, fontsize: 24)),
              InkWell(
                onTap: () {
                  bottonController.indexChanger(1);
                },
                child: Text("See all",
                    style: googleFontStyle(
                        fontweight: FontWeight.w500,
                        fontsize: 18,
                        color: Colors.blue)),
              )
            ],
          ),
        ),
        GetX<DestinationController>(builder: (controller) {
          if (controller.destinations.isEmpty) {
            return const CircularProgressIndicator();
          }
          return SizedBox(
            height: screenHeight * 0.33,
            width: double.infinity,
            child: ListView.builder(
              itemCount: controller.destinations.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  DestinationCardWidget(controller: controller, index: index),
            ),
          );
        }),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.03,
            right: screenWidth * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return destinationController.isNearBy.value
                    ? Text('Nearby Me',
                        style: googleFontStyle(
                            fontsize: 23, fontweight: FontWeight.w500))
                    : Text("Recomended",
                        style: googleFontStyle(
                            fontsize: 23, fontweight: FontWeight.w500));
              }),
              InkWell(
                onTap: () {
                  bottonController.indexChanger(1);
                },
                child: Text("See all",
                    style: googleFontStyle(
                        fontweight: FontWeight.w500,
                        fontsize: 18,
                        color: Colors.blue)),
              )
            ],
          ),
        ),
        GetX<DestinationController>(builder: (controller) {
          if (controller.destinationsNearbyMe.isEmpty) {
            //here should add shimmer
            return const CircularProgressIndicator();
          }
          return SizedBox(
            width: double.infinity,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.destinationsNearbyMe.length,
              itemBuilder: (context, index) => DestinationTileWidget(
                  index: index, controller: destinationController),
            ),
          );
        })
      ],
    );
  }
}
