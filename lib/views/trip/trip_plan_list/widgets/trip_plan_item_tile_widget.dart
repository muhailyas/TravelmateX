import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelmatex/utils/constants/constants.dart';

import '../../../../models/trip_plan_model.dart';
import '../../../../utils/colors/colors.dart';

class TripPlanItemTileWidget extends StatelessWidget {
  const TripPlanItemTileWidget({
    super.key,
    required this.tripData,
  });

  final TripPlanModel tripData;

  @override
  Widget build(BuildContext context) {
    final start = DateFormat('dd/MM/yyyy').format(tripData.startDate);
    final end = DateFormat('dd/MM/yyyy').format(tripData.endtDate);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035, vertical: screenWidth * 0.02),
      child: Container(
        height: screenHeight * 0.1,
        decoration: BoxDecoration(
            color: whiteColorWithOpacity150,
            borderRadius: BorderRadius.circular(screenHeight * 0.015)),
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.015),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.45,
                    child: Text(tripData.tripName,
                        overflow: TextOverflow.ellipsis,
                        style: googleFontStyle(
                            fontweight: FontWeight.bold, fontsize: 23)),
                  ),
                  SizedBox(
                    width: screenWidth * 0.38,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("From:$start",
                            style:
                                googleFontStyle(fontweight: FontWeight.w500)),
                        Text("To:$end",
                            style:
                                googleFontStyle(fontweight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
