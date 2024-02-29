import 'package:flutter/material.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Column(children: [
                Text(
                  'About',
                  style: googleFontStyle(
                      fontsize: 35, fontweight: FontWeight.w500),
                ),
                Text(
                  "TravelMate is your ultimate travel companion, passionate about uncovering the captivating allure of \"God's Own Country,\" Kerala. Immerse yourself in vibrant festivals, cultural dances, and delectable cuisine that tantalize your senses. Glide through tranquil backwaters, trek misty hills, and embrace sandy beaches along the Arabian Sea. Engage in thrilling water sports and wildlife encounters, creating unforgettable memories."
                  "Unravel history at ancient temples and forts, where echoes of the past resonate. With TravelMate's customizable filters, craft a personalized journey that suits your preferences. Experience warm hospitality and friendly smiles, exploring the unique charm of Kerala."
                  "Whether seeking cultural exploration, thrilling escapades, or serene moments in nature's bounty, Kerala promises an indelible mark on your heart. Let TravelMate be your guide, creating cherished memories for a lifetime. Start your unforgettable adventure now!",
                  style: googleFontStyle(
                      fontweight: FontWeight.w300, letterSpacing: 1),
                  textAlign: TextAlign.justify,
                ),
              ]),
            ],
          ),
        ),
      )),
    );
  }
}
