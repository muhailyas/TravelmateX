import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/favorite_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/favorite/destination_card_widget/destination_card_widget.dart';

import '../detail/detail_screen.dart';

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
    return GestureDetector(
      onTap: () {
        Get.to(const DetailScreen(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 500),
            arguments: {'destination': favoriteController.favorites[index]});
      },
      child: DestinationTileFavoriteWidget(
        favoriteController: favoriteController,
        index: index,
        screenHeight: screenHeight,
      ),
    );
  }
}
