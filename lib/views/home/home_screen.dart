import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/controllers/search_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/location_widget/location_widget.dart';
import 'widgets/search_content_widget/search_content_widget.dart';
import 'widgets/search_field_widget/search_field_widget.dart';
import 'widgets/whole_content_widget/whole_contrent_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final searchController =
      Get.put<SearchControllerHome>(SearchControllerHome());
  final destinationController =
      Get.put<DestinationController>(DestinationController());
  @override
  Widget build(BuildContext context) {
    destinationController.fetchDestinations();
    destinationController.fetchDestinationNearbyMe(null);
    final user = FirebaseAuth.instance.currentUser;
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    return SingleChildScrollView(
      child: Column(
        children: [
          height10,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                        stream: userDocRef.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            Map<String, dynamic>? data =
                                snapshot.data!.data() as Map<String, dynamic>?;
                            return data != null
                                ? Text(
                                    "Hi ${data['name']},",
                                    style: googleFontStyle(
                                        fontsize: 25,
                                        fontweight: FontWeight.w400,
                                        color: Colors.grey),
                                  )
                                : const SizedBox();
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                    Text(
                      "Travelling Today?",
                      style: googleFontStyle(
                          fontsize: 35, fontweight: FontWeight.w600),
                    ),
                    const Row(
                      children: [Icon(Icons.location_on), LocationAccess()],
                    )
                  ],
                ),
                IconButton(
                    splashColor: transparentColor,
                    splashRadius: 1,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.now_widgets_rounded,
                      size: 40,
                    ))
              ],
            ),
          ),
          SearchFieldWidget(searchController: searchController, destinationController: destinationController),
          height10,
          GetX<SearchControllerHome>(
            builder: (controller) {
              return searchController.isSearching.value
                  ? SearchContentWidget(destinationController: destinationController)
                  : WholeContentWidget();
            },
          )
        ],
      ),
    );
  }
}
