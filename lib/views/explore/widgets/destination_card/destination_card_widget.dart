import 'package:flutter/material.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/favorite_icon_widget/favorite_icon_widget.dart';

class DestinationCardExplore extends StatelessWidget {
  const DestinationCardExplore(
      {super.key, required this.filterController, required this.index});

  final FilterController filterController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                filterController.filteredList[index].destinationImageUrls[0]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: screenHeight * 0.064,
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColorWithOpacity50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: _buildDestinationInfo(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).textScaleFactor * 10,
        vertical: MediaQuery.of(context).textScaleFactor * 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(child: _buildDestinationDetails(context)),
          FavoriteIcon(destinationId: filterController.filteredList[index].id!),
        ],
      ),
    );
  }

  Widget _buildDestinationDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filterController.filteredList[index].destinationName,
          style: googleFontStyle(
            fontweight: FontWeight.bold,
            fontsize: MediaQuery.of(context).textScaleFactor * 17,
            color: textColorBlackWithOpacity,
          ),
        ),
        Text(
          "${filterController.filteredList[index].destinationDistrict}, ${filterController.filteredList[index].destinationCategory}",
          style: googleFontStyle(
            fontsize: MediaQuery.of(context).textScaleFactor * 14,
            fontweight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
