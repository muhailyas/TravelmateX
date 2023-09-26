import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/services/favorite_services.dart';

class FavoriteController extends GetxController {
  final favoriteIds = <String>[].obs;
  final favorites = <Destination>[].obs;
  initFavorites() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    favoriteIds.value = await FavoriteServices().getFavoriteIds(userId);
    favorites.value =
        await FavoriteServices().getFavoriteDestinations(favoriteIds);
  }

  void addFavorite(String destinationId) {
    if (!favoriteIds.contains(destinationId)) {
      favoriteIds.add(destinationId);
      FavoriteServices().addFavorite(destinationId);
    }
  }

  void removeFavorite(String destinationId) {
    if (favoriteIds.contains(destinationId)) {
      favoriteIds.remove(destinationId);
      FavoriteServices().removeFavorite(destinationId);
    }
  }
}
