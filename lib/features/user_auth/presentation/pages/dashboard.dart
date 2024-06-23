import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide Direction;
import 'dart:math';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });
  static const double defaultFontSize = 45.0;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ChartData> chartData = [];
  int allRoomsCount = 0;
  int availRoomsCount = 0;
  int bookRoomsCount = 0;

  _updateCountData() {
    setState(() {
      chartData = [
        ChartData('Rooms', allRoomsCount.toDouble(), const Color(0xff005f60)),
        ChartData(
            'Available', availRoomsCount.toDouble(), const Color(0xff73c5c5)),
        ChartData('Booked', bookRoomsCount.toDouble(), const Color(0xff009596)),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseServices _databaseService = DatabaseServices();
    final User? uzer = FirebaseAuth.instance.currentUser;
    double responsiveFontSize = MediaQuery.of(context).size.width * 0.2;

    return SafeArea(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 8,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(
                    width: 2,
                    color: EXColors.primaryDark,
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: EXColors.primaryDark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rooms',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StreamBuilder(
                              stream: _databaseService.getAllRooms(uzer?.uid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  List allRooms =
                                      snapshot.data?.docs.cast<dynamic>() ?? [];
                                  allRoomsCount = allRooms.length;
                                  Future.microtask(() => _updateCountData());
                                }
                                return Container(
                                  margin: const EdgeInsets.all(3),
                                  padding: const EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width *
                                      0.5455,
                                  height:
                                      MediaQuery.of(context).size.width * 0.65,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff005f60),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                          color: EXColors.primaryLight,
                                          fontSize: 30,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '$allRoomsCount',
                                          style: const TextStyle(
                                            color: EXColors.primaryLight,
                                            fontSize: 100,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            Column(
                              children: [
                                StreamBuilder(
                                  stream: _databaseService
                                      .getRoomsNotAvaiable(uzer?.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      List bookRooms =
                                          snapshot.data?.docs.cast<dynamic>() ??
                                              [];
                                      bookRoomsCount = bookRooms.length;
                                      Future.microtask(
                                          () => _updateCountData());
                                    }
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.32,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff009596),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Booked',
                                            style: TextStyle(
                                              color: EXColors.primaryLight,
                                              fontSize: 25,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              '$bookRoomsCount',
                                              style: TextStyle(
                                                color: EXColors.primaryLight,
                                                fontSize: responsiveFontSize >
                                                        Dashboard
                                                            .defaultFontSize
                                                    ? Dashboard.defaultFontSize
                                                    : responsiveFontSize,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                StreamBuilder(
                                  stream: _databaseService
                                      .getRoomsAvaiable(uzer?.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      List availRooms =
                                          snapshot.data?.docs.cast<dynamic>() ??
                                              [];
                                      availRoomsCount = availRooms.length;
                                      Future.microtask(
                                          () => _updateCountData());
                                    }
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.32,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff73c5c5),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Available',
                                            style: TextStyle(
                                              color: EXColors.primaryLight,
                                              fontSize: 25,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              '$availRoomsCount',
                                              style: TextStyle(
                                                color: EXColors.primaryLight,
                                                fontSize: responsiveFontSize >
                                                        Dashboard
                                                            .defaultFontSize
                                                    ? Dashboard.defaultFontSize
                                                    : responsiveFontSize,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: EXColors.primaryDark,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(13),
                                  bottomRight: Radius.circular(13),
                                ),
                              ),
                              child: Center(
                                  child:
                                      SfCircularChart(series: <CircularSeries>[
                                // Render pie chart
                                PieSeries<ChartData, String>(
                                  dataSource: chartData,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true),
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                )
                              ])),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.4,
                                  0,
                                  0,
                                  0),
                              child: ArcText(
                                text: 'ROOMS',
                                radius: MediaQuery.of(context).size.width * 0.4,
                                direction: Direction.clockwise,
                                startAngleAlignment: StartAngleAlignment.end,
                                startAngle: -(pi / 9),
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
