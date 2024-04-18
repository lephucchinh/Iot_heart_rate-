import 'package:cloud_firestore/cloud_firestore.dart';

class MyData {
  DateTime changedAt;
  num heartRate;
  String id;

  MyData({required this.changedAt, required this.heartRate, required this.id});

  Map<String, Object?> toDocument() {
    return {
      "changedAt": changedAt,
      "heartRate": heartRate,
      "id": id
    };
  }

  static MyData fromDocument(Map<String, dynamic> doc) {
    return MyData(
      changedAt: (doc["changedAt"] as Timestamp).toDate(),
      heartRate: doc["heartRate"] as num,
      id: doc['id'] as String,
    );
  }
}
