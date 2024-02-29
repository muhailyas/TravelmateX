import 'package:cloud_firestore/cloud_firestore.dart';

class TripPlanModel {
  String? id;
  String tripName;
  DateTime startDate;
  DateTime endtDate;
  String? notes;
  TripPlanModel({
    this.id,
    required this.tripName,
    required this.startDate,
    required this.endtDate,
    this.notes,
  });
  factory TripPlanModel.fromJson(Map<String, dynamic> json) {
    return TripPlanModel(
      id: json['trip id'],
      tripName: json['trip name'],
      startDate: (json['start date'] as Timestamp).toDate(),
      endtDate: (json['end date'] as Timestamp).toDate(),
      notes: json['notes'],
    );
  }
}
