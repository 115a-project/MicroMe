
import 'package:fl_chart/fl_chart.dart' as bar_chart;      // fl_chart: ^0.50.5
import 'package:flutter/material.dart';
import 'package:testing/Pages/charts/water_data.dart';
import 'package:testing/Pages/charts/data.dart';

// https://github.com/JohannesMilke/fl_bar_chart_example/blob/master/lib/widget/bar_chart_widget.dart

class BarChartWidget extends StatelessWidget {
  final double barWidth = 22;

  const BarChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => bar_chart.BarChart(
        bar_chart.BarChartData(
          alignment: bar_chart.BarChartAlignment.center,
          maxY: 100,
          minY: 0,
          groupsSpace: 12,
          barTouchData: bar_chart.BarTouchData(enabled: true),
          barGroups: BarData.barData.map(
            (data) => bar_chart.BarChartGroupData(
              x: data.id,
              barRods: [
                bar_chart.BarChartRodData(
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