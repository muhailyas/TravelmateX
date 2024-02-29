import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/controllers/search_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/animation/fade_in.dart';
import 'widgets/appbar_widget/appbar_widget.dart';
import 'widgets/search_content_widget/search_content_widget.dart';
import 'widgets/search_field_widget/search_field_widget.dart';
import 'widgets/whole_content_widget/whole_contrent_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final destinationController = Get.find<DestinationController>();
  final searchController = Get.find<SearchControllerHome>();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          height10,
          FadeInAnimation(
            delay: 5,
            direction: FadeInDirection.ttb,
            fadeOffset: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBarWidget(userDocRef: userDocRef),
                  IconButton(
                      splashColor: transparentColor,
                      splashRadius: 1,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.now_widgets_rounded,
                        size: screenHeight * 0.04,
                      ))
                ],
              ),
            ),
          ),
          FadeInAnimation(
            delay: 5,
            direction: FadeInDirection.btt,
            fadeOffset: 50,
            child: SearchFieldWidget(
                searchController: searchController,
                destinationController: destinationController),
          ),
          height10,
          GetX<SearchControllerHome>(
            builder: (controller) {
              return searchController.isSearching.value
                  ? SearchContentWidget(
                      destinationController: destinationController)
                  : WholeContentWidget();
            },
          )
        ],
      ),
    );
  }
}
