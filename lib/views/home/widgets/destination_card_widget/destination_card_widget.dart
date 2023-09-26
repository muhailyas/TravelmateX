import 'package:flutter/material.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
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
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
        elevation: 2,
        child: Container(
          width: 205,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    image: DecorationImage(
                        image: NetworkImage(
                            destinations[index].destinationImageUrls[0]),
                        fit: BoxFit.cover)),
                height: screenHeight * 0.23,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.33,
                      child: Text(
                        destinations[index].destinationName,
                        style: googleFontStyle(fontweight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    FavoriteIcon(destinationId: destinations[index].id!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                    "${destinations[index].destinationDistrict}, ${destinations[index].destinationCategory}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
