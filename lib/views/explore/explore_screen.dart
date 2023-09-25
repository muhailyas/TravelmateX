import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/utils/constants/lists.dart';
import 'widgets/filter_check_box_widget/filter_check_box_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final FilterController filterController = Get.put(FilterController());

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
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: screenHeight * 0.25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(filterController
                                  .filteredList[index].destinationImageUrls[0]),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(25)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: screenHeight * 0.064,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filterController.filteredList[index]
                                            .destinationName,
                                        style: googleFontStyle(
                                            fontweight: FontWeight.w500,
                                            fontsize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                17),
                                      ),
                                      Text(
                                          "${filterController.filteredList[index].destinationDistrict}, ${filterController.filteredList[index].destinationCategory}",
                                          style: googleFontStyle(
                                              fontsize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14,
                                              fontweight: FontWeight.w400))
                                    ],
                                  ),
                                  const Icon(Icons.favorite)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        )
      ],
    );
  }
}
