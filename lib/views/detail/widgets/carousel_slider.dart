import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.destination,
  });

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Center(
        child: CarouselSlider(
          options: CarouselOptions(
              // height: 380,
              height: screenHeight * 0.36,
              autoPlay: true,
              enlargeCenterPage:
                  true, // Make the current page larger than others
              viewportFraction: 1.5),
          items: destination.destinationImageUrls.map((imageUrl) {
            return Container(
              width: MediaQuery.of(context).size.width * .95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
