import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelmatex/models/destination_model.dart';

class FavoriteServices {
  FavoriteServices._();
  static final FavoriteServices instance = FavoriteServices._();
  factory FavoriteServices() => instance;

  // getfavoriteIds
  Future<List<String>> getFavoriteIds(String userId) async {
    final favoritesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    final favoriteIds = favoritesSnapshot.docs.map((doc) => doc.id).toList();
    return favoriteIds;
  }

  //get favorite destinations
  Future<List<Destination>> getFavoriteDestinations(
      List<String> favoriteIds) async {
    final favoriteDestinations = await Future.wait(favoriteIds.map(
        (destinationId) => FirebaseFirestore.instance
            .collection('destinations')
            .doc(destinationId)
            .get()));

    final favoriteDestinationData = favoriteDestinations.map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      return Destination(
        id: snapshot.id,
        destinationName: data['name'],
        destinationDistrict: data['district'],
        destinationCategory: data['category'],
        destinationLocation: data['location'],
        destinationDescription: data['description'],
        destinationImageUrls: List<String>.from(data['ImageUrls']),
      );
    }).toList();
    return favoriteDestinationData;
  }

  // add favorite
  void addFavorite(String destinationId) {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .doc(destinationId)
          .set({'timestamp': FieldValue.serverTimestamp()});
    }
  }
  // remove from favorite

  void removeFavorite(String destinationId) {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorites')
          .doc(destinationId)
          .delete();
    }
  }
}
