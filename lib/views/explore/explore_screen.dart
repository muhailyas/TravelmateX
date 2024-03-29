import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/utils/constants/lists.dart';
import 'package:travelmatex/views/detail/detail_screen.dart';
import 'widgets/destination_card/destination_card_widget.dart';
import 'widgets/filter_check_box_widget/filter_check_box_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final filterController = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    filterController.getFiltered();
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Explore ",
                    style: googleFontStyle(
                        fontweight: FontWeight.w500,
                        fontsize: MediaQuery.of(context).textScaleFactor * 25),
                  ),
                ),
                const Divider(),
              ],
            ),
          )
        ];
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Select district',
                style:
                    googleFontStyle(fontsize: 14, fontweight: FontWeight.w500)),
          ),
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
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Select district',
                style:
                    googleFontStyle(fontsize: 14, fontweight: FontWeight.w500)),
          ),
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
                    "Selected combination not found !",
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
                    return GestureDetector(
                      onTap: () {
                        Get.to(const DetailScreen(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 500),
                            arguments: {
                              'destination':
                                  filterController.filteredList[index]
                            });
                      },
                      child: DestinationCardExplore(
                          filterController: filterController, index: index),
                    );
                  },
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
