import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/destination_model.dart';
import '../../../models/trip_plan_model.dart';
import '../../../utils/constants/constants.dart';

ValueNotifier<List<Destination>> destiantionViewerNotifier =
    ValueNotifier<List<Destination>>([]);

class TripPlanInfo extends StatelessWidget {
  const TripPlanInfo({
    super.key,
    required this.tripInfo,
  });
  final TripPlanModel tripInfo;

  getSelectedDestination(String tripInfoid) async {
    final collectionIds = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trip plans')
        .doc(tripInfoid)
        .collection('destinationIds')
        .get();

    final destinationIds =
        collectionIds.docs.map((destination) => destination.id).toList();

    final collectionDestinations = await Future.wait(destinationIds.map(
        (destinationId) => FirebaseFirestore.instance
            .collection('destinations')
            .doc(destinationId)
            .get()));

    final destinations = collectionDestinations.map((doc) {
      return Destination.fromSnapshot(doc);
    }).toList();
    destiantionViewerNotifier.value = destinations;
  }

  @override
  Widget build(BuildContext context) {
    getSelectedDestination(tripInfo.id!);
    print(destiantionViewerNotifier.value);
    bool isNotesVisible = tripInfo.notes!.isEmpty;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  tripInfo.tripName,
                  style: googleFontStyle(
                      fontsize: 25, fontweight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.47,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(183, 39, 215, 228),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "Start Date: ${DateFormat('dd/MM/yyyy').format(tripInfo.startDate)}",
                              overflow: TextOverflow.ellipsis,
                              style: googleFontStyle(
                                  fontsize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontweight: FontWeight.w500),
                            ),
                          )),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 5,
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(183, 39, 215, 228),
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: Center(
                              child: Text(
                            "End Date: ${DateFormat('dd/MM/yyyy').format(tripInfo.endtDate)}",
                            overflow: TextOverflow.ellipsis,
                            style: googleFontStyle(
                                fontsize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontweight: FontWeight.w500),
                          ))),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: !isNotesVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Remarks',
                      style: googleFontStyle(
                          fontsize: 25, fontweight: FontWeight.w500),
                    ),
                  )),
              Visibility(
                visible: !isNotesVisible,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(tripInfo.notes!),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Destiantions',
                  style: googleFontStyle(
                      fontsize: 25, fontweight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                    valueListenable: destiantionViewerNotifier,
                    builder: (context, List<Destination> list, _) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15),
                          itemBuilder: (context, index) {
                            var data = list[index];
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data.destinationImageUrls[0],
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 40,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            181, 228, 228, 228),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.destinationName,
                                            style: googleFontStyle(
                                                fontsize: 17,
                                                fontweight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${data.destinationDistrict}, ${data.destinationCategory}",
                                            style: googleFontStyle(
                                                fontsize: 13,
                                                fontweight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
