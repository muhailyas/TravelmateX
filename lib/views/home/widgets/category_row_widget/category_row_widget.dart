import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/routes/app_routes.dart';
import 'package:travelmatex/utils/constants/constants.dart';
import 'package:travelmatex/utils/constants/lists.dart';

class CategoryRowWidget extends StatelessWidget {
  const CategoryRowWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.075,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.categoryList,
                  arguments: {'argument1': categories[index][0]});
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 242, 242),
                  borderRadius: BorderRadius.circular(25)),
              constraints: const BoxConstraints(minWidth: 120),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                        minRadius: 20,
                        backgroundImage: AssetImage(categories[index][1])),
                    const SizedBox(width: 10),
                    Text(
                      categories[index][0],
                      style: googleFontStyle(
                          fontsize: 16, fontweight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        itemCount: categories.length - 2,
      ),
    );
  }
}
