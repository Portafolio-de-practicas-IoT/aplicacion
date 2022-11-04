import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData();

  final double foodLevel = 0.64;
  final double waterLevel = 0.9;
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

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
                      child: _buildElevationDoughnutChart(
                          67, Color.fromARGB(0, 127, 225, 173)),
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
                      child: _buildElevationDoughnutChart(
                          90, Color.fromARGB(0, 95, 106, 248)),
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
                child: _buildTrackerColumnChart(),
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
                child: Table(
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      width: 1,
                    ),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCell(
                            child: Text(""),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Age",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Status",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Weight",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCell(
                            child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "https://cdn.arstechnica.net/wp-content/uploads/2022/04/GettyImages-997016774.jpg")),
                          ),
                        ),
                        TableCell(
                          child: Text("Sierra"),
                        ),
                        TableCell(
                          child: Text("3 years"),
                        ),
                        TableCell(
                          child: Text("Well fed"),
                        ),
                        TableCell(
                          child: Text("14.65kg"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCell(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  "https://www.princeton.edu/sites/default/files/styles/half_2x/public/images/2022/02/KOA_Nassau_2697x1517.jpg?itok=iQEwihUn"),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Text("Astro"),
                        ),
                        TableCell(
                          child: Text("3 months"),
                        ),
                        TableCell(
                          child: Text("Bad fed"),
                        ),
                        TableCell(
                          child: Text("640gr"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCell(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  "https://cdn.britannica.com/49/161649-050-3F458ECF/Bernese-mountain-dog-grass.jpg"),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Text("Sky"),
                        ),
                        TableCell(
                          child: Text("8 years"),
                        ),
                        TableCell(
                          child: Text("Well fed"),
                        ),
                        TableCell(
                          child: Text("23.4kg"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
  SfCartesianChart _buildTrackerColumnChart() {
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
      series: _getTracker(),
    );
  }

  /// Get column series with tracker
  List<ColumnSeries<CartesianChartSampleData, String>> _getTracker() {
    return <ColumnSeries<CartesianChartSampleData, String>>[
      ColumnSeries<CartesianChartSampleData, String>(
          dataSource: <CartesianChartSampleData>[
            CartesianChartSampleData(
                x: 'monday_food',
                y: 71,
                pointColor: Color.fromARGB(1000, 127, 225, 173)),
            CartesianChartSampleData(
                x: 'tuesday_food',
                y: 84,
                pointColor: Color.fromARGB(1000, 127, 225, 173)),
            CartesianChartSampleData(
                x: 'wednesday_food',
                y: 48,
                pointColor: Color.fromARGB(1000, 127, 225, 173)),
            CartesianChartSampleData(
                x: 'thursday_food',
                y: 80,
                pointColor: Color.fromARGB(1000, 127, 225, 173)),
            CartesianChartSampleData(
                x: 'friday_food',
                y: 76,
                pointColor: Color.fromARGB(1000, 127, 225, 173)),
            CartesianChartSampleData(
                x: 'saturday_food',
                y: 60,
                pointColor: Color.fromARGB(1000, 127, 225, 173)),
            CartesianChartSampleData(
                x: 'sunday_food',
                y: 70,
                pointColor: Color.fromARGB(1000, 127, 225, 173)),
            CartesianChartSampleData(
                x: 'monday_water',
                y: 50,
                pointColor: Color.fromARGB(1000, 95, 106, 248)),
            CartesianChartSampleData(
                x: 'tuesday_water',
                y: 60,
                pointColor: Color.fromARGB(1000, 95, 106, 248)),
            CartesianChartSampleData(
                x: 'wednesday_water',
                y: 70,
                pointColor: Color.fromARGB(1000, 95, 106, 248)),
            CartesianChartSampleData(
                x: 'thursday_water',
                y: 80,
                pointColor: Color.fromARGB(1000, 95, 106, 248)),
            CartesianChartSampleData(
                x: 'friday_water',
                y: 90,
                pointColor: Color.fromARGB(1000, 95, 106, 248)),
            CartesianChartSampleData(
                x: 'saturday_water',
                y: 100,
                pointColor: Color.fromARGB(1000, 95, 106, 248)),
            CartesianChartSampleData(
                x: 'sunday_water',
                y: 100,
                pointColor: Color.fromARGB(1000, 95, 106, 248)),
          ],

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
