
import 'package:fl_chart/fl_chart.dart';      // fl_chart: ^0.50.5
import 'package:flutter/material.dart';
import 'package:testing/Pages/charts/water_data.dart';
import 'package:testing/Pages/charts/data.dart';

// https://github.com/JohannesMilke/fl_bar_chart_example/blob/master/lib/widget/bar_chart_widget.dart

class BarChartWidget extends StatelessWidget {
  final double barWidth = 22;

  const BarChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 100,
          minY: 0,
          groupsSpace: 12,
          barTouchData: BarTouchData(enabled: true),
          // titlesData: FlTitlesData(
          //   topTitles: BarTitles.getTopBottomTitles(),
          //   bottomTitles: BarTitles.getTopBottomTitles(),
          //   leftTitles: BarTitles.getSideTitles(),
          //   rightTitles: BarTitles.getSideTitles(),
          // ),
          // gridData: FlGridData(
          //   checkToShowHorizontalLine: (value) => value % BarData.interval == 0,
          //   getDrawingHorizontalLine: (value) {
          //     if (value == 0) {
          //       return FlLine(
          //         color: const Color(0xff363753),
          //         strokeWidth: 3,
          //       );
          //     } else {
          //       return FlLine(
          //         color: const Color(0xff2a2747),
          //         strokeWidth: 0.8,
          //       );
          //     }
          //   },
          // ),
          barGroups: BarData.barData.map(
            (data) => BarChartGroupData(
              x: data.id,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  width: barWidth,
                  color: data.color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                ),
              ],
            ),
          ).toList(),
        ),
      );
}