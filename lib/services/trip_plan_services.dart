import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelmatex/models/destination_model.dart';
import '../models/trip_plan_model.dart';

ValueNotifier<List<TripPlanModel>> getAllTripPlanNotifier =
    ValueNotifier<List<TripPlanModel>>([]);

class TripPlanRepository {
  Future<List<TripPlanModel>> getTripPlans() async {
    final allTripPlans = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trip plans')
        .get();
    final allPlans =
        allTripPlans.docs.map((e) => TripPlanModel.fromJson(e.data())).toList();
    return allPlans;
  }

  // add function
  addTrip(TripPlanModel tripPlanModel, List<Destination> destinationIds) async {
    final tripRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trip plans')
        .doc();

    await tripRef.set({
      'trip id': tripRef.id,
      'trip name': tripPlanModel.tripName,
      'start date': Timestamp.fromDate(tripPlanModel.startDate),
      'end date': Timestamp.fromDate(tripPlanModel.endtDate),
      'notes': tripPlanModel.notes,
    });

    for (var value in destinationIds) {
      addDestination(value.id!, tripRef.id);
    }
  }

  // delete trip functions
  Future<void> deleteTrip(String tripId) async {
    final tripRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trip plans')
        .doc(tripId);

    final destinationIds = await tripRef.collection('destinationIds').get();
    await Future.forEach(destinationIds.docs,
        (destinationDocs) async => await destinationDocs.reference.delete());
    await tripRef.delete();
  }

  // addDestiantion
  addDestination(String destinationId, String tripId) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trip plans')
        .doc(tripId)
        .collection('destinationIds')
        .doc(destinationId)
        .set({'time stamb': FieldValue.serverTimestamp()});
  }

  // remove destiantion
  Future<void> removeDestination(String destinationId, String tripId) async {
    final path = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trip plans')
        .doc(tripId);
    await path.collection('destinationIds').doc(destinationId).delete();
  }
}
