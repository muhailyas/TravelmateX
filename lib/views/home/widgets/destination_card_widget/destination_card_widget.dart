import 'package:flutter/material.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/animation/fade_in.dart';
import 'package:travelmatex/views/widgets/favorite_icon_widget/favorite_icon_widget.dart';

class DestinationCardWidget extends StatelessWidget {
  const DestinationCardWidget(
      {super.key,
      required this.controller,
      required this.index,
      this.isSearch = false});
  final DestinationController controller;
  final bool isSearch;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Destination> destinations = [];
    if (isSearch) {
      destinations = controller.searchResult;
    } else {
      destinations = controller.destinations;
    }
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Material(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        elevation: 2,
        child: Container(
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
              FadeInAnimation(
                delay: 5,
                direction: FadeInDirection.ltr,
                fadeOffset: 60,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(
                              destinations[index].destinationImageUrls[0]),
                          fit: BoxFit.cover)),
                  height: screenHeight * 0.23,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    child: FadeInImage(
                      placeholder: const AssetImage(
                          'assets/modern-flat-icon-landscape_203633-11062.avif'), // Placeholder image
                      image: NetworkImage(destinations[index]
                          .destinationImageUrls[0]), // Network image
                      fit: BoxFit.cover,
                    ),
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
                      child: FadeInAnimation(
                        delay: 5,
                        direction: FadeInDirection.rtl,
                        fadeOffset: 50,
                        child: Text(
                          destinations[index].destinationName,
                          style: googleFontStyle(fontweight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    FadeInAnimation(
                        delay: 5,
                        direction: FadeInDirection.ttb,
                        fadeOffset: 50,
                        child: FavoriteIcon(
                            destinationId: destinations[index].id!)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: FadeInAnimation(
                  delay: 5,
                  direction: FadeInDirection.ltr,
                  fadeOffset: 50,
                  child: Text(
                      "${destinations[index].destinationDistrict}, ${destinations[index].destinationCategory}",
                      overflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
