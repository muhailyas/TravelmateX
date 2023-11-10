import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/favorite_icon_widget/favorite_icon_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteController favoriteController;
  @override
  void initState() {
    favoriteController = Get.find<FavoriteController>();
    favoriteController.initFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height05,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Favorites',
            style: googleFontStyle(fontweight: FontWeight.w500, fontsize: 25),
          ),
        ),
        const Divider(),
        FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Color.fromARGB(255, 3, 40, 70),
                    ),
                  ),
                ),
              );
            }
            return buildFavoritesList(context);
          },
        ),
      ],
    );
  }

  Widget buildFavoritesList(BuildContext context) {
    return Obx(() {
      if (favoriteController.favorites.isEmpty) {
        return buildEmptyFavorites();
      }
      return buildNonEmptyFavorites(context);
    });
  }

  Widget buildEmptyFavorites() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: double.infinity),
          Text(
            'No favorites added yet?',
            style: googleFontStyle(fontsize: 23, fontweight: FontWeight.w700),
          ),
          Text(
            'Your favorites list is waiting to be filled!',
            style: googleFontStyle(fontsize: 17, fontweight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget buildNonEmptyFavorites(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: favoriteController.favorites.length,
        itemBuilder: (context, index) {
          return buildFavoriteItem(context, index);
        },
      ),
    );
  }

  Widget buildFavoriteItem(BuildContext context, int index) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                    Column(
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
