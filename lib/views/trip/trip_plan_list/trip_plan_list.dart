import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/trip_plan_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/trip/trip_info/trip_info.dart';
import 'package:travelmatex/views/trip/trip_plan/trip_plan.dart';
import 'widgets/trip_plan_item_tile_widget.dart';

class ScreenTripPlans extends StatelessWidget {
  ScreenTripPlans({super.key});
  final tripController = Get.find<TripPlanController>();

  @override
  Widget build(BuildContext context) {
    tripController.getAllTrips();
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: backGroundColor,
            title: Text(
              "Planned Trips",
              style: googleFontStyle(fontweight: FontWeight.w500, fontsize: 25),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(const ScreenTripPlan(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 500));
                  },
                  icon: const Icon(Icons.add_circle_outline_rounded,
                      size: 30, color: blackColor))
            ],
          ),
          const SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverFillRemaining(
            child: Obx(() {
              if (tripController.tripPlans.isEmpty) {
                return Center(
                    child: Text("No trips added yet?",
                        style: googleFontStyle(fontweight: FontWeight.bold)));
              }
              return ListView.builder(
                itemCount: tripController.tripPlans.length,
                itemBuilder: (context, index) {
                  final tripData = tripController.tripPlans[index];
                  return GestureDetector(
                      onLongPress: () {
                        tripController.deleteTrip(tripData.id!);
                      },
                      onTap: () {
                        Get.to(TripPlanInfo(tripInfo: tripData),
                            transition: Transition.fadeIn);
                      },
                      child: TripPlanItemTileWidget(tripData: tripData));
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
