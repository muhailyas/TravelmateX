import 'package:get/get.dart';

class SearchControllerHome extends GetxController {
  Rx<bool> isSearching = Rx<bool>(false);
  toggleSearch() => isSearching.value = true;
}
