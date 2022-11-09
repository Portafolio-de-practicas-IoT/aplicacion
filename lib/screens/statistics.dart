import 'package:app/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.blue,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: SideMenu(
        currentPath: "/statistics",
      ),
      body: _getStatistics(context),
    );
  }

  BlocConsumer<StatisticsBloc, StatisticsState> _getStatistics(
      BuildContext context) {
    return BlocConsumer<StatisticsBloc, StatisticsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is StatisticsLoaded) {
          return _statistics(state.statistics);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _statistics(Map<String, dynamic> statistics) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Food level',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: _getFoodChart(statistics),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Water level',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: _getWaterChart(statistics),
                  )
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'Week status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                thickness: 3,
                indent: 20,
                endIndent: 20,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              child: _getStatuChart(statistics),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Average time eating",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Average time drinking",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "10 min",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "5 times",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.only(left: 20),
                child: _getPetsTable(statistics),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getFoodChart(Map<String, dynamic> statistics) {
    final foodLevel = statistics["food_level"];
    return _buildElevationDoughnutChart(
        foodLevel, Color.fromARGB(0, 127, 225, 173));
  }

  Widget _getWaterChart(Map<String, dynamic> statistics) {
    final waterLevel = statistics["water_level"];
    return _buildElevationDoughnutChart(
        waterLevel, Color.fromARGB(0, 95, 106, 248));
  }

  Widget _getStatuChart(Map<String, dynamic> statistics) {
    final foodStatus = statistics["history"]["food"];
    final waterStatus = statistics["history"]["water"];

    List<CartesianChartSampleData> status = [];

    for (var i = 0; i < foodStatus.length; i++) {
      status.add(new CartesianChartSampleData(
          x: i.toString(),
          y: foodStatus[i].toDouble(),
          pointColor: Color.fromARGB(1000, 127, 225, 173)));
    }

    for (var i = 0; i < waterStatus.length; i++) {
      status.add(new CartesianChartSampleData(
          x: (i + 6).toString(),
          y: waterStatus[i].toDouble(),
          pointColor: Color.fromARGB(1000, 95, 106, 248)));
    }

    return _buildTrackerColumnChart(status);
  }

  Table _getPetsTable(Map<String, dynamic> statistics) {
    final pets = statistics["pets"];

    Table table = Table(
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          width: 1,
        ),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _getRows(pets),
    );

    return table;
  }

  List<TableRow> _getRows(pets) {
    List<TableRow> rows = [];

    rows.add(TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(""),
        ),
        Container(
          child: Text(
            "Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          child: Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          child: Text(
            "Status",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          child: Text(
            "Weight",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ));

    for (var i = 0; i < pets.length; i++) {
      rows.add(TableRow(children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(pets[i]["image"]),
              backgroundColor: Colors.grey,
            ),
          ),
        ),
        TableCell(
          child: Text(pets[i]["name"]),
        ),
        TableCell(
          child: Text(pets[i]["age"]),
        ),
        TableCell(
          child: Text(pets[i]["status"]),
        ),
        TableCell(
          child: Text(pets[i]["weight"]),
        ),
      ]));
    }

    return rows;
  }

  /// Returns the circular charts with center elevation dughnut series.
  SfCircularChart _buildElevationDoughnutChart(double x, Color color) {
    return SfCircularChart(
      /// It used to set the annotation on circular chart.
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '100%',
            width: '100%',
            widget: PhysicalModel(
              shape: BoxShape.circle,
              elevation: 0,
              color: Colors.transparent,
              child: Container(),
            )),
        CircularChartAnnotation(
            widget: Text('$x%',
                style: TextStyle(
                  color: Color.fromRGBO(color.red, color.green, color.blue, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )))
      ],
      series: _getElevationDoughnutSeries(x, color),
      margin: const EdgeInsets.all(0),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries(
      double x, Color color) {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          innerRadius: '80%',
          dataSource: <ChartSampleData>[
            ChartSampleData(x: 'A', y: x, pointColor: color),
            ChartSampleData(
                x: 'B',
                y: 100 - x,
                pointColor: Color.fromRGBO(230, 230, 230, 1))
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor)
    ];
  }

  /// Get column series with track
  SfCartesianChart _buildTrackerColumnChart(
      List<CartesianChartSampleData> data) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      backgroundColor: Colors.grey[200],
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0), isVisible: false),
      primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: 0,
          maximum: 100,
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getTracker(data),
    );
  }

  /// Get column series with tracker
  List<ColumnSeries<CartesianChartSampleData, String>> _getTracker(
      List<CartesianChartSampleData> data) {
    return <ColumnSeries<CartesianChartSampleData, String>>[
      ColumnSeries<CartesianChartSampleData, String>(
          dataSource: data,

          /// We can enable the track for column here.
          isTrackVisible: false,
          trackColor: const Color.fromRGBO(198, 201, 207, 1),
          borderRadius: BorderRadius.circular(15),
          xValueMapper: (CartesianChartSampleData sales, _) => sales.x,
          yValueMapper: (CartesianChartSampleData sales, _) => sales.y,
          pointColorMapper: (CartesianChartSampleData sales, _) =>
              sales.pointColor,
          name: 'Marks',
          dataLabelSettings: const DataLabelSettings(
              isVisible: false,
              labelAlignment: ChartDataLabelAlignment.top,
              textStyle: TextStyle(fontSize: 10, color: Colors.white)))
    ];
  }
}

class ChartSampleData {
  ChartSampleData({this.x, required this.y, required this.pointColor});

  final dynamic x;
  final double y;
  final Color pointColor;
}

class CartesianChartSampleData {
  CartesianChartSampleData(
      {required this.x, required this.y, required this.pointColor});

  final String x;
  final double y;
  final Color pointColor;
}
