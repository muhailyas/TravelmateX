import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/filter_controller.dart';
import 'package:travelmatex/utils/colors/colors.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class CategoryListScreen extends StatelessWidget {
  CategoryListScreen({super.key});
  final filterController = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String category = arguments['argument1'];
    filterController.getDestinationByCategory(category);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: backGroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          category,
          style: googleFontStyle(fontweight: FontWeight.w400, fontsize: 22),
        ),
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, value) {
            if (value.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Obx(() {
              if (filterController.destinationByCateogryList.isEmpty) {
                return const Center(
                  child: Text("Not found"),
                );
              }
              return ListView.builder(
                itemCount: filterController.destinationByCateogryList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: screenHeight * 0.25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(filterController
                                  .destinationByCateogryList[index]
                                  .destinationImageUrls[0]),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(25)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: screenHeight * 0.064,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filterController
                                            .destinationByCateogryList[index]
                                            .destinationName,
                                        style: googleFontStyle(
                                            fontweight: FontWeight.w500,
                                            fontsize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                17),
                                      ),
                                      Text(
                                          "${filterController.destinationByCateogryList[index].destinationDistrict}, ${filterController.destinationByCateogryList[index].destinationCategory}",
                                          style: googleFontStyle(
                                              fontsize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14,
                                              fontweight: FontWeight.w400))
                                    ],
                                  ),
                                  const Icon(Icons.favorite)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }),
    );
  }
}
