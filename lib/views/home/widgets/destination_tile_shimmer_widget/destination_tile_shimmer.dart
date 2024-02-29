import 'package:flutter/material.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class DestinationTileShimmerWidget extends StatelessWidget {
  const DestinationTileShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(25),
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(68, 158, 158, 158),
          highlightColor: const Color.fromARGB(22, 255, 255, 255),
          child: Container(
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              color: const Color.fromARGB(83, 255, 255, 255),
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
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                    ),
                  ),
                  width10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 100,
                        color: const Color.fromARGB(83, 255, 255, 255),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 12,
                        width: 150,
                        color: const Color.fromARGB(83, 255, 255, 255),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
