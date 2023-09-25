

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';

import '../../../../controllers/filter_controller.dart';

class FilterCheckBox extends StatelessWidget {
  FilterCheckBox({
    super.key,
    required this.title,
    required this.onTap,
    this.isCategory = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool isCategory;
  final FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = isCategory
          ? filterController.selectedCategories.contains(title)
          : filterController.selectedDistricts.contains(title);
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: onTap,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(25),
            child: Container(
              constraints: BoxConstraints(minWidth: screenWidth * 0.2),
              decoration: BoxDecoration(
                color: isSelected ? blackColor : whiteColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * .02),
                  child: Text(
                    title,
                    style: googleFontStyle(
                        fontsize: 14,
                        fontweight: FontWeight.w500,
                        color: isSelected ? whiteColor : blackColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
