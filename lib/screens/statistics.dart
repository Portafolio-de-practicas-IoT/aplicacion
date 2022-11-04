import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  Map<String, dynamic> mockedData = {
    "food_level": 67.0,
    "water_level": 99.0,
    "history": {
      "food": [71, 84, 48, 80, 74, 67],
      "water": [57, 99, 39, 67, 49, 87]
    },
    "pets": [
      {
        "name": "Sierra",
        "age": "3 years",
        "status": "Well fed",
        "weight": "14.65Kg",
        "image":
            "https://cdn.arstechnica.net/wp-content/uploads/2022/04/GettyImages-997016774.jpg"
      },
      {
        "name": "Astro",
        "age": "3 months",
        "status": "Bad fed",
        "weight": "640g",
        "image":
            "https://www.princeton.edu/sites/default/files/styles/half_2x/public/images/2022/02/KOA_Nassau_2697x1517.jpg?itok=iQEwihUn"
      },
      {
        "name": "Sky",
        "age": "8 years",
        "status": "Well fed",
        "weight": "23.4Kg",
        "image":
            "https://cdn.britannica.com/49/161649-050-3F458ECF/Bernese-mountain-dog-grass.jpg"
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const Drawer(),
      body: Column(
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
                      child: _getFoodChart(),
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
                      child: _getWaterChart(),
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
                child: _getStatuChart(),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.only(left: 20),
                child: _getPetsTable(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getFoodChart() {
    final foodLevel = mockedData["food_level"];
    return _buildElevationDoughnutChart(
        foodLevel, Color.fromARGB(0, 127, 225, 173));
  }

  Widget _getWaterChart() {
    final waterLevel = mockedData["water_level"];
    return _buildElevationDoughnutChart(
        waterLevel, Color.fromARGB(0, 95, 106, 248));
  }

  Widget _getStatuChart() {
    final foodStatus = mockedData["history"]["food"];
    final waterStatus = mockedData["history"]["water"];

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

  Widget _getPetsTable() {
    final pets = mockedData["pets"];

    List<TableRow> rows = [];

    // Table headers
    rows.add(TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(""),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "Status",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            child: CircleAvatar(
                radius: 20, backgroundImage: NetworkImage(pets[i]["image"])),
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

    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          width: 1,
        ),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: rows,
    );
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
