import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/favorite_icon_widget/favorite_icon_widget.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    favoriteController.initFavorites();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Favorites',
            style: googleFontStyle(fontweight: FontWeight.w500, fontsize: 25),
          ),
        ),
        FutureBuilder(
            future: Future.delayed(const Duration(seconds: 1)),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Color.fromARGB(255, 3, 40, 70))),
                  ),
                );
              }
              return Obx(() {
                if (favoriteController.favorites.isEmpty) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: double.infinity),
                        Text(
                          'No favorites added yet?',
                          style: googleFontStyle(
                              fontsize: 23, fontweight: FontWeight.w700),
                        ),
                        Text(
                          'Your favorites list is waiting to be filled!',
                          style: googleFontStyle(
                              fontsize: 17, fontweight: FontWeight.w300),
                        )
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: favoriteController.favorites.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: screenHeight * 0.25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(favoriteController
                                      .favorites[index]
                                      .destinationImageUrls[0]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(25)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: screenHeight * 0.064,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favoriteController.favorites[index]
                                                .destinationName,
                                            style: googleFontStyle(
                                                fontweight: FontWeight.w500,
                                                fontsize: MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    17),
                                          ),
                                          Text(
                                              "${favoriteController.favorites[index].destinationDistrict}, ${favoriteController.favorites[index].destinationCategory}",
                                              style: googleFontStyle(
                                                  fontsize:
                                                      MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          14,
                                                  fontweight: FontWeight.w400))
                                        ],
                                      ),
                                      FavoriteIcon(
                                          destinationId: favoriteController
                                              .favorites[index].id!)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              });
            })
      ],
    );
  }
}
