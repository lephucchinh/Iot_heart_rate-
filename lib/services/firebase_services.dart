import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

import '../entity/my_data.dart';

class FirebaseService {
  final realtimeDatabase = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://iot-realtime-a0b41-default-rtdb.europe-west1.firebasedatabase.app/',
  );
  final database = FirebaseFirestore.instance.collection('heartbeat');



  Stream<num> getDataStream() {
    final ref = realtimeDatabase.ref('data/SpO2');
    final temperatureStream =
        ref.onValue.map((event) => event.snapshot.value as num);
    return temperatureStream;
  }

  FirebaseService() {
    print('update');
    final debounceDuration = Duration(seconds: 1); // Thời gian đợi 1 giây

    Timer? _debounceTimer;

    realtimeDatabase.ref('data/Heart_rate').onValue.listen((event) {
      final data = event.snapshot.value as num;
      _debounceTimer?.cancel();
      _debounceTimer = Timer(debounceDuration, () {
        // Xử lý dữ liệu mới sau khi thời gian đợi kết thúc
        setData(data);
      });
    });
  }

  Future<void> setData(num data) async {
    try {
      print('setdata');

      MyData myData = MyData(
          changedAt: DateTime.now(), heartRate: data, id: const Uuid().v1());

      database.doc(myData.id).set(myData.toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Stream<List<MyData>> getMyData() {
    return database
        .orderBy("changedAt", descending: true)
        .snapshots()
        .map((snapshot) {
      List<MyData> myDataList = snapshot.docs
          .map((doc) => MyData.fromDocument(doc.data()))
          .toList();

      // Nếu có nhiều hơn 20 dữ liệu, chỉ lấy 20 dữ liệu mới nhất
      if (myDataList.length > 20) {

        myDataList = myDataList.take(20).toList();

        // Nếu có nhiều hơn 30 dữ liệu, chỉ lấy 30 dữ liệu mới nhất
        if (myDataList.length > 30) {
          List<String> oldestIds = snapshot.docs
              .sublist(20) // Lấy danh sách các documents từ vị trí 20 đến cuối
              .map((doc) => doc.id)
              .toList();
          // Xóa các documents có ID nằm trong danh sách oldestIds
          oldestIds.forEach((id) {
            database.doc(id).delete();
          });
        }
      }

      return myDataList;
    });
  }
  }
