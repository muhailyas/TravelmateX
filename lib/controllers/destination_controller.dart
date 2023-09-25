import 'package:get/get.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/services/firebase_services.dart';

class DestinationController extends GetxController {
  RxList<Destination> destinations = RxList([]);
  void fetchDestinations() async {
    destinations.value = await DestinationRepo().fetchDestinations();
  }

  RxList<Destination> destinationsNearbyMe = RxList([]);
  RxBool isNearBy = false.obs;

  void fetchDestinationNearbyMe(String? district) async {
    final allDestinations = await DestinationRepo().fetchDestinations();
    if (district != null && district.isNotEmpty) {
      destinationsNearbyMe.value = allDestinations.reversed
          .where((destination) =>
              destination.destinationDistrict.toLowerCase() ==
              district.toLowerCase())
          .toList();
      destinationsNearbyMe.isNotEmpty ? isNearBy.value = true : false;
    } else {
      destinationsNearbyMe.value = allDestinations.reversed.toList();
      isNearBy.value = false;
    }
  }

  RxList<Destination> searchResult = RxList([]);
  void searchDestinations(String searchQuery) async {
    final allDeatinations = await DestinationRepo().fetchDestinations();
    searchResult.value = allDeatinations
        .where((destination) => destination.destinationName
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }
}
