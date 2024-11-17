// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, non_constant_identifier_names

import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/transaction_data_provider.dart';
import '../../../utils/themes_data.dart';
import '../../../widgets/custom_title.dart';

class MyIncomeExpenseGraph extends StatefulWidget {
  var args;
  MyIncomeExpenseGraph(this.args, {super.key});

  @override
  State<MyIncomeExpenseGraph> createState() => _MyIncomeExpenseGraphState();
}

class _MyIncomeExpenseGraphState extends State<MyIncomeExpenseGraph> {
  List<num> sumList = [];

  num temp = 0;

  bool showAverage = false;

  @override
  Widget build(BuildContext context) {
    sumList = [];
    temp = 0;
    double screenHeight = MediaQuery.of(context).size.height - 56;
    double screenWidth = MediaQuery.of(context).size.width;
    final data = widget.args[1] as String == "Income"
        ? Provider.of<TransactionDataProvider>(context, listen: false)
            .incomeList
        : Provider.of<TransactionDataProvider>(context, listen: false)
            .expenseList;

    for (int i = 0; i < data!.length; i++) {
      if (showAverage == false) {
        if (data[i].amount < 0) {
          temp += (data[i].amount * -1);
        } else {
          temp += data[i].amount;
        }
        sumList.add(temp);
      } else {
        if (data[i].amount < 0) {
          sumList.add(data[i].amount * -1);
        } else {
          sumList.add(data[i].amount);
        }
      }
    }
    List<LineTooltipItem> GraphToolTipDesign(List<LineBarSpot> data) {
      List<LineTooltipItem> test = [
        LineTooltipItem(
          
            sumList.length < 15
                ? "${data[0].y}"
                : "${data[0].x.toInt()}\n${data[0].y}",
            TextStyle(
                color: widget.args[1] as String == "Income"
                    ? incomeDark
                    : expenseDark,
                fontWeight: FontWeight.bold,
                fontSize: 13))
      ];
      return test;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30, right: 20),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: screenWidth < 155
                    ? " "
                    : screenWidth < 210
                        ? widget.args[1] as String
                        : "${widget.args[1] as String} Report",
                transition: false,
              ),
              Tooltip(
                showDuration: const Duration(seconds: 2),
                triggerMode: TooltipTriggerMode.tap,
                onTriggered: Platform.isWindows
                    ? null
                    : () {
                        setState(() {
                          showAverage = !showAverage;
                        });
                      },
                preferBelow: false,
                decoration: const BoxDecoration(color: Colors.transparent),
                margin: const EdgeInsets.all(0),
                richMessage: WidgetSpan(
                    child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      showAverage
                          ? "Frequency Graph"
                          : "Cumulative ${widget.args[1] as String} Graph",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: font3,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                child: IconButton(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.line_axis_sharp,
                    color: Colors.grey,
                    size: 22,
                  ),
                  onPressed: Platform.isWindows
                      ? () {
                          setState(() {
                            showAverage = !showAverage;
                          });
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                height: screenHeight * 0.22,
                child: Center(
                  child: LineChart(
                    LineChartData(
                        backgroundColor: Colors.transparent,
                        lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (touchedSpot) {
                                return Colors.white;
                              },
                                tooltipPadding: const EdgeInsets.all(0),
                                getTooltipItems: (touchedSpots) =>
                                    GraphToolTipDesign(touchedSpots))),
                        borderData: FlBorderData(border: const Border()),
                        titlesData: FlTitlesData(
                          rightTitles:
                              const AxisTitles(drawBelowEverything: false),
                          leftTitles:
                              const AxisTitles(drawBelowEverything: false),
                          topTitles:
                              const AxisTitles(drawBelowEverything: false),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: sumList.length < 15 ? true : false,
                              interval: 1,
                              getTitlesWidget: (value, meta) =>
                                  showTitle(value),
                              reservedSize: 30,
                            ),
                          ),
                        ),
                        gridData: FlGridData(
                          checkToShowHorizontalLine: (value) => true,
                          checkToShowVerticalLine: (value) => false,
                          getDrawingHorizontalLine: (value) => FlLine(
                              color: Theme.of(context).secondaryHeaderColor,
                              strokeWidth: 0.6,
                              dashArray: [5, 3]),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            belowBarData: BarAreaData(
                              show: false,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: widget.args[1] == "Income"
                                    ? [
                                        ColorTween(
                                                begin: incomeDark,
                                                end: incomeDark)
                                            .lerp(1)!
                                            .withOpacity(0.4),
                                        ColorTween(
                                                begin: incomeLight,
                                                end: incomeLight)
                                            .lerp(1)!
                                            .withOpacity(0.3),
                                        ColorTween(
                                                begin: Colors.white,
                                                end: Colors.white)
                                            .lerp(1)!
                                            .withOpacity(0.0),
                                      ]
                                    : [
                                        ColorTween(
                                                begin: expenseDark,
                                                end: expenseDark)
                                            .lerp(1)!
                                            .withOpacity(0.4),
                                        ColorTween(
                                                begin: expenseLight,
                                                end: expenseLight)
                                            .lerp(1)!
                                            .withOpacity(0.3),
                                        ColorTween(
                                                begin: Colors.white,
                                                end: Colors.white)
                                            .lerp(1)!
                                            .withOpacity(0.0),
                                      ],
                              ),
                            ),
                            gradient: LinearGradient(
                              colors: widget.args[1] == "Income"
                                  ? [incomeDark2, incomeDark, incomeLight]
                                  : [expenseDark2, expenseDark, expenseLight],
                            ),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                      radius: 4,
                                      color: widget.args[1] == "Income"
                                          ? expenseDark
                                          : incomeDark,
                                      strokeColor: Colors.white,
                                      strokeWidth: 2),
                              checkToShowDot: (spot, barData) {
                                if (spot.x == 0 && spot.y == 0 ||
                                    spot.x == sumList.length) {
                                  return false;
                                } else if (sumList.length < 12) {
                                  return true;
                                } else if (sumList.length < 22) {
                                  return spot.x % 2 == 0 ? true : false;
                                } else if (sumList.length < 32) {
                                  return spot.x % 3 == 0 ? true : false;
                                } else if (sumList.length < 42) {
                                  return spot.x % 4 == 0 ? true : false;
                                } else if (sumList.length < 52) {
                                  return spot.x % 5 == 0 ? true : false;
                                } else if (sumList.length < 62) {
                                  return spot.x % 6 == 0 ? true : false;
                                } else if (sumList.length < 72) {
                                  return spot.x % 7 == 0 ? true : false;
                                } else {
                                  return spot.x % 12 == 0 ? true : false;
                                }
                              },
                            ),
                            spots: [
                              const FlSpot(0, 0),
                              for (int i = 1; i <= sumList.length; i++)
                                FlSpot(i.toDouble(), sumList[i - 1].toDouble()),
                            ],
                            shadow: const Shadow(
                                offset: Offset(0, 3),
                                color: Color.fromARGB(30, 0, 0, 0)),
                            barWidth: 2.5,
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget showTitle(double value) {
  return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: Text(
        (value.toInt().toString()),
        style: const TextStyle(
          fontFamily: font1,
          fontWeight: FontWeight.bold,
          fontSize: 13,
          letterSpacing: 1.5,
          color: Color.fromARGB(255, 179, 179, 179),
        ),
      ));
}


//https://pub.dev/packages/fl_animated_linechart/example