import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class FavoriteIcon extends StatelessWidget {
  FavoriteIcon({super.key, required this.destinationId});
  final String destinationId;
  final favoriteController = Get.find<FavoriteController>();
  toggleFavorite() {
    if (favoriteController.favoriteIds.contains(destinationId)) {
      favoriteController.removeFavorite(destinationId);
    } else {
      favoriteController.addFavorite(destinationId);
    }
    favoriteController.initFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: toggleFavorite,
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: screenHeight * 0.04,
            width: screenHeight * 0.04,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: favoriteController.favoriteIds.contains(destinationId)
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border, color: Colors.grey),
            ),
          ),
        ),
      );
    });
  }
}
