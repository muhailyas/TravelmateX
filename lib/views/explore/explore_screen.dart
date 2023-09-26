import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/utils/constants/lists.dart';
import 'widgets/destination_card/destination_card_widget.dart';
import 'widgets/filter_check_box_widget/filter_check_box_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final filterController = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    filterController.getFiltered();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Explore ",
            style: googleFontStyle(fontweight: FontWeight.w500, fontsize: 25),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: screenHeight * 0.05,
          width: double.infinity,
          child: ListView.builder(
            itemCount: districts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final district = districts[index];
              return FilterCheckBox(
                title: district,
                onTap: () {
                  filterController.toggleDistrict(district);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: screenHeight * 0.05,
          width: double.infinity,
          child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = categories[index][0];
              return FilterCheckBox(
                title: category,
                onTap: () {
                  filterController.toggleCategory(category);
                },
                isCategory: true,
              );
            },
          ),
        ),
        Expanded(
          child: Obx(() {
            if (filterController.filteredList.isEmpty) {
              return Center(
                child: Text(
                  "Try another way !",
                  style: googleFontStyle(fontweight: FontWeight.w500),
                ),
              );
            }
            return SizedBox(
              height: screenHeight,
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filterController.filteredList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return DestinationCardExplore(
                      filterController: filterController, index: index);
                },
              ),
            );
          }),
        )
      ],
    );
  }
}
