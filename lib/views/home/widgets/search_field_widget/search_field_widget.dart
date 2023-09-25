import 'package:flutter/material.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/controllers/search_controller.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
    required this.searchController,
    required this.destinationController,
  });

  final SearchControllerHome searchController;
  final DestinationController destinationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.06,
      width: screenWidth * 0.96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 245, 242, 242),
      ),
      child: TextField(
        cursorColor: Colors.black,
        onChanged: (value) {
          if (value.isNotEmpty) {
            searchController.toggleSearch();
            destinationController.searchDestinations(value);
          } else {
            searchController.isSearching.value = false;
          }
        },
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search_rounded, color: Colors.black),
            hintText: 'Search destination...',
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
