import 'package:flutter/material.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class DestinationTileWidget extends StatelessWidget {
  const DestinationTileWidget(
      {super.key, required this.index, required this.controller});
  final int index;
  final DestinationController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: screenHeight * 0.1,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: screenHeight * 0.08,
                  width: screenWidth * 0.18,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(controller
                              .destinationsNearbyMe[index]
                              .destinationImageUrls[0]),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                ),
                width10,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          controller
                              .destinationsNearbyMe[index].destinationName,
                          style: googleFontStyle(fontweight: FontWeight.w400),
                        ),
                      ),
                      Text(
                          "${controller.destinationsNearbyMe[index].destinationDistrict}, ${controller.destinationsNearbyMe[index].destinationCategory}")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
