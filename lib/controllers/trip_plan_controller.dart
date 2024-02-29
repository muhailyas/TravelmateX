import 'package:get/get.dart';
import 'package:travelmatex/models/destination_model.dart';
import 'package:travelmatex/models/trip_plan_model.dart';
import 'package:travelmatex/services/trip_plan_services.dart';

class TripPlanController extends GetxController {
  RxList<TripPlanModel> tripPlans = <TripPlanModel>[].obs;
  final TripPlanRepository _tripPlanRepository = TripPlanRepository();
  void getAllTrips() async {
    tripPlans.value = await _tripPlanRepository.getTripPlans();
  }

  void addTrip(
      TripPlanModel tripPlanModel, List<Destination> destinationIds) async {
    _tripPlanRepository.addTrip(tripPlanModel, destinationIds);
    getAllTrips();
  }

  void deleteTrip(String tripId) async {
    await _tripPlanRepository.deleteTrip(tripId);
    getAllTrips();
  }
}
