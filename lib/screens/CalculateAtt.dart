// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class CalculateAtt extends StatelessWidget {
  final String attended;

  final String conducted;

  CalculateAtt({Key? key, required this.attended, required this.conducted})
      : super(key: key);

  late double x = double.parse(attended);
  late double y = double.parse(conducted);

  late double percentage = (x / y) * 100;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Bunk Manager',
            style: GoogleFonts.lobster(
              color: Colors.white,
              fontSize: 25,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Your Attendence percentage :',
                    style: TextStyle(
                      fontSize: 17,
                    )),
                const SizedBox(
                  height: 1,
                ),
                Text(percentage.toStringAsFixed(2),
                    style: TextStyle(
                      color: percentage > 75 ? Colors.green : Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: PieChart(
              dataMap: {
                "attended": percentage,
                "Not Attended": 100 - percentage
              },
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: [Colors.green, Colors.red],
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: 'percentage',
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                //legendShape: _BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Center(
              child: percentage < 75
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text(
                            'You still need to attend',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "${((0.75 * y - x) / 0.25).toStringAsFixed(0)} classes",
                            style: TextStyle(
                              color: Color.fromRGBO(232, 156, 156, 1),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "to get to 75%",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          )
                        ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'You are good to go..',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                          ),
                        )
                      ],
                    )),
          SizedBox(
            height: 50,
          ),
          DynamicPercentage(
            conducted: y,
            attended: x,
            percentage: percentage,
          ),
        ],
      ),
    );
  }
}

class DynamicPercentage extends StatefulWidget {
  late double percentage;
  late double conducted;
  late double attended;
  DynamicPercentage(
      {super.key,
      required this.conducted,
      required this.attended,
      required this.percentage});

  @override
  State<DynamicPercentage> createState() => _DynamicPercentageState();
}

class _DynamicPercentageState extends State<DynamicPercentage> {
  late double _per = widget.percentage;
  int _pre = 0;
  int _abs = 0;
  late double a = widget.attended;
  late double b = widget.conducted;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _per.toStringAsFixed(2),
          style: TextStyle(
            color: _per >= 75 ? Colors.green : Colors.red,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Present : \t" + _pre.toString(),
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Absent : \t" + _abs.toString(),
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  _present();
                },
                child: Text('Present')),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  _absent();
                },
                child: Text('Absent')),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  _reset();
                },
                child: Text('Reset')),
            Spacer(),
          ],
        )
      ],
    ));
  }

  _present() {
    setState(() {
      _pre++;
      _per = (++a / ++b) * 100;
    });
  }

  _absent() {
    setState(() {
      _abs++;
      _per = (a / ++b) * 100;
    });
  }

  _reset() {
    setState(() {
      _abs = 0;
      _pre = 0;
      a = widget.attended;
      b = widget.conducted;
      _per = (widget.attended / (widget.conducted)) * 100;
    });
  }
}
