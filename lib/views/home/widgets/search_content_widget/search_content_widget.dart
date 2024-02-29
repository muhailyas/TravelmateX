import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/destination_controller.dart';
import 'package:travelmatex/views/detail/detail_screen.dart';
import 'package:travelmatex/views/home/widgets/destination_card_widget/destination_card_widget.dart';

class SearchContentWidget extends StatelessWidget {
  const SearchContentWidget({
    super.key,
    required this.destinationController,
  });

  final DestinationController destinationController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (destinationController.searchResult.isEmpty) {
        return Center(
          child: Image.asset("assets/search resultN.png"),
        );
      }
      return SizedBox(
        width: double.infinity,
        child: GridView.builder(
          itemCount: destinationController.searchResult.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(const DetailScreen(),
                    duration: const Duration(seconds: 1),
                    arguments: {
                      'destination': destinationController.searchResult[index]
                    });
              },
              child: DestinationCardWidget(
                  controller: destinationController,
                  index: index,
                  isSearch: true),
            );
          },
        ),
      );
    });
  }
}
