import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/trip/trip_plan/trip_plan.dart';
import '../../../../utils/colors/colors.dart';

class ScreenSelectPlaces extends StatelessWidget {
  ScreenSelectPlaces({super.key});
  final DestinationController controller = Get.find<DestinationController>();

  @override
  Widget build(BuildContext context) {
    controller.searchDestinations('');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Places",
                style:
                    googleFontStyle(fontweight: FontWeight.bold, fontsize: 23),
              ),
              TextField(
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search places",
                    border: InputBorder.none),
                onChanged: (value) {
                  controller.searchDestinations(value);
                },
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.searchResult.length,
                      itemBuilder: (context, index) {
                        return SelectPlaceDestinationCardWidget(
                            controller: controller, index: index);
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectPlaceDestinationCardWidget extends StatelessWidget {
  const SelectPlaceDestinationCardWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  final DestinationController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Material(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        elevation: 2,
        child: Container(
          height: screenHeight * 0.3,
          width: screenWidth * 0.49,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(controller
                            .searchResult[index].destinationImageUrls[0]),
                        fit: BoxFit.cover)),
                height: screenHeight * 0.23,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  child: FadeInImage(
                    placeholder: const AssetImage(
                        'assets/modern-flat-icon-landscape_203633-11062.avif'),
                    image: NetworkImage(
                        controller.searchResult[index].destinationImageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.33,
                      child: Text(
                        controller.searchResult[index].destinationName,
                        style: googleFontStyle(fontweight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedDestinationIdsforTripPlannings.value
                            .add(controller.searchResult[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: screenHeight * 0.03,
                        width: screenHeight * 0.03,
                        decoration: const BoxDecoration(
                          color: whiteColorWithOpacity150,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.add_circle_outline_rounded,
                              color: blackColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Text(
                    "${controller.searchResult[index].destinationDistrict}, ${controller.searchResult[index].destinationCategory}",
                    overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
      ),
    );
  }
}
