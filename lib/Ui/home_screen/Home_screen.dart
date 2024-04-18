import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../entity/my_data.dart';
import '../../services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 30,
              child: Center(
                  child: Text(
                "CHART HEARTBEAT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Container(
              width: 150,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monitor_heart,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  StreamBuilder<num>(
                      stream: FirebaseService().getDataStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            '${snapshot.error}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          );
                        } else {
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          );
                        }
                      }),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.indigoAccent,
                  )),
              height: 400,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Ink(
                          width: 25,
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<List<MyData>>(
                      stream: FirebaseService().getMyData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          log(snapshot.error.toString());
                          return Text(snapshot.error.toString());
                        } else if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.isEmpty) {

                          return Text('Không có dữ liệu');
                        } else {
                          List<MyData>? data = snapshot.data;
                          return Center(
                            child: SfSparkLineChart.custom(
                              // Sử dụng các thuộc tính của SfSparkLineChart để tùy chỉnh biểu đồ Spark
                              trackball: SparkChartTrackball(
                                activationMode: SparkChartActivationMode.tap,
                              ),
                              dataCount: data?.length,
                              xValueMapper: (int index) => data?[index].changedAt,
                              yValueMapper: (int index) => data![index].heartRate,
                              labelDisplayMode: SparkChartLabelDisplayMode.all,

                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.seconds, this.heartRate);

  final double seconds;
  final double heartRate;
}
