import 'package:get/get.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/services/firebase_services.dart';

class FilterController extends GetxController {
  final selectedDistricts = <String>[].obs;
  final selectedCategories = <String>[].obs;
  final filteredList = <Destination>[].obs;

  toggleDistrict(String district) {
    if (selectedDistricts.contains(district)) {
      selectedDistricts.remove(district);
    } else {
      selectedDistricts.add(district);
    }
    getFiltered();
  }

  toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    getFiltered();
  }

  getFiltered() async {
    filteredList.value = await DestinationRepo().filterDestinations(
        selectedDistricts: selectedDistricts,
        selectedCategories: selectedCategories);
  }

  final destinationByCateogryList = <Destination>[].obs;
  getDestinationByCategory(String category) async {
    final allDestinations = await DestinationRepo().fetchDestinations();
    destinationByCateogryList.value = allDestinations
        .where((destination) => destination.destinationCategory
            .toLowerCase()
            .contains(category.toLowerCase()))
        .toList();
  }
}
