import 'package:flutter/material.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/favorite_icon_widget/favorite_icon_widget.dart';

class DestinationTileFavoriteWidget extends StatelessWidget {
  const DestinationTileFavoriteWidget({
    super.key,
    required this.screenHeight,
    required this.favoriteController,
    required this.index,
  });
  final int index;

  final double screenHeight;
  final FavoriteController favoriteController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              favoriteController.favorites[index].destinationImageUrls[0],
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: Container(
              height: screenHeight * 0.064,
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColorWithOpacity50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.01,
                  vertical: screenHeight * 0.005,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favoriteController.favorites[index].destinationName,
                            style: googleFontStyle(
                              fontweight: FontWeight.bold,
                              fontsize:
                                  MediaQuery.of(context).textScaleFactor * 17,
                              color: const Color.fromARGB(176, 0, 0, 0),
                            ),
                          ),
                          Text(
                            "${favoriteController.favorites[index].destinationDistrict}, ${favoriteController.favorites[index].destinationCategory}",
                            style: googleFontStyle(
                              fontsize:
                                  MediaQuery.of(context).textScaleFactor * 14,
                              fontweight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FavoriteIcon(
                      destinationId: favoriteController.favorites[index].id!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
