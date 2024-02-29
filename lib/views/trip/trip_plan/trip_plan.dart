import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/trip_plan_controller.dart';
import 'package:travelmatex/views/trip/trip_plan/select_places/select_places.dart';
import '../../../models/destination_model.dart';
import '../../../models/trip_plan_model.dart';
import '../../../utils/constants/constants.dart';
import 'widgets/calender_widget.dart';

ValueNotifier<List<Destination>> selectedDestinationIdsforTripPlanning =
    ValueNotifier<List<Destination>>([]);
ValueNotifier<List<Destination>> selectedDestinationIdsforTripPlannings =
    ValueNotifier<List<Destination>>([]);

class ScreenTripPlan extends StatefulWidget {
  const ScreenTripPlan({Key? key}) : super(key: key);

  @override
  ScreenTripPlanState createState() => ScreenTripPlanState();
}

class ScreenTripPlanState extends State<ScreenTripPlan> {
  final _tripPlanerKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  final _notPadEditingController = TextEditingController();
  final tripController = Get.find<TripPlanController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        selectedDestinationIdsforTripPlannings.value.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const Icon(
            Icons.map_outlined,
            color: Colors.black,
          ),
          title: Text('Plan your trip',
              style:
                  googleFontStyle(fontsize: 23, fontweight: FontWeight.w400)),
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Form(
              key: _tripPlanerKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      // Trip name field
                      child: TextFormField(
                        controller: _tripNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'trip name is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(73, 226, 226, 226),
                          filled: true,
                          hintText: 'Trip Name',
                          labelStyle: googleFontStyle(
                            fontsize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  const CalenderWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 5,
                      child: TextField(
                        controller: _notPadEditingController,
                        maxLines: null,
                        decoration: const InputDecoration(
                            labelText: 'Notes...',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder<List<Destination>>(
                          valueListenable:
                              selectedDestinationIdsforTripPlannings,
                          builder: (context, List<Destination> value, child) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(value[index]
                                              .destinationImageUrls[0]),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: const Icon(
                                            Icons.remove_circle_rounded),
                                        onPressed: () => setState(() {
                                          selectedDestinationIdsforTripPlannings
                                              .value
                                              .remove(value[index]);
                                        }),
                                      )),
                                );
                              },
                              itemCount: selectedDestinationIdsforTripPlannings
                                  .value.length,
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScreenSelectPlaces()));
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 35,
                            color: Colors.black,
                          ),
                          label: FittedBox(
                            child: Text(
                              'Add Destinations',
                              style: googleFontStyle(
                                  fontsize: MediaQuery.of(context).size.height *
                                      0.019,
                                  fontweight: FontWeight.w500),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(strokeAlign: 0.1),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.465,
                                  MediaQuery.of(context).size.height * 0.06),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.015,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_tripPlanerKey.currentState!.validate()) {
                              validation(context);
                            }
                          },
                          icon: const Icon(
                            Icons.save,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: FittedBox(
                            child: Text(
                              'Save Trip',
                              style: googleFontStyle(
                                  fontsize: MediaQuery.of(context).size.height *
                                      0.019,
                                  color: Colors.white,
                                  fontweight: FontWeight.w500),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.45,
                                  MediaQuery.of(context).size.height * 0.06),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> validation(context) async {
    if (_tripNameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Trip name is required')));
      return false;
    } else if (selectedStartDate == null && selectedEndDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select trip start date and end date')));
      return false;
    } else if (selectedStartDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select trip start date')));
      return false;
    } else if (selectedEndDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Select trip end date')));
      return false;
    } else if (selectedDestinationIdsforTripPlannings.value.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Add destinaitons')));
      return false;
    } else {
      final tripPlanModel = TripPlanModel(
          tripName: _tripNameController.text,
          startDate: selectedStartDate!,
          endtDate: selectedEndDate!,
          notes: _notPadEditingController.text.isEmpty
              ? ''
              : _notPadEditingController.text);
      tripController.addTrip(
          tripPlanModel, selectedDestinationIdsforTripPlannings.value);
      setState(() {
        _tripNameController.clear();
        selectedStartDate = null;
        selectedEndDate = null;
        _notPadEditingController.clear();
        selectedDestinationIdsforTripPlannings.value.clear();
      });
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip added successfully')));
      return true;
    }
  }
}
