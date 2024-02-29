import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/services/url_services.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/views/widgets/favorite_icon_widget/favorite_icon_widget.dart';

import 'widgets/carousel_slider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    Destination destination = arguments['destination'];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            //first half container
            CarouselSliderWidget(destination: destination),
            // name district category column
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.013),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination.destinationName,
                              style: googleFontStyle(
                                  fontsize: 25, fontweight: FontWeight.w600),
                            ),
                            Text(
                              "${destination.destinationDistrict}, ${destination.destinationCategory}",
                              style: googleFontStyle(
                                  fontsize: 14, fontweight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    //favorite
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.055,
                          width: MediaQuery.of(context).size.height * 0.055,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(185, 170, 165, 165),
                          ),
                          child: FavoriteIcon(destinationId: destination.id!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // second half container
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.013,
                right: MediaQuery.of(context).size.height * 0.013,
              ),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.44,
                // main column
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Divider(color: Color.fromARGB(255, 66, 66, 66)),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'About',
                          style: googleFontStyle(
                              fontsize: 22, fontweight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        destination.destinationDescription,
                        textAlign: TextAlign.justify,
                        style: googleFontStyle(
                            fontsize: 19, fontweight: FontWeight.w300),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17)),
                                  backgroundColor: Colors.white,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .46,
                                      MediaQuery.of(context).size.height *
                                          0.06),
                                  side: const BorderSide(strokeAlign: 0.01)),
                              child: Text(
                                'Back',
                                style: googleFontStyle(
                                    fontweight: FontWeight.w600,
                                    fontsize:
                                        MediaQuery.of(context).size.height *
                                            0.025),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                createdlaunchUrl(
                                    destination.destinationLocation);
                              },
                              icon: const Icon(Icons.location_on),
                              label: FittedBox(
                                child: Text(
                                  'Get Direction',
                                  style: googleFontStyle(
                                      fontsize:
                                          MediaQuery.of(context).size.height *
                                              0.024,
                                      fontweight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17)),
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .47,
                                      MediaQuery.of(context).size.height *
                                          0.06)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
