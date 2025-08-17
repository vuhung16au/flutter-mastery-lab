import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartsDemo extends StatelessWidget {
  const ChartsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Line Chart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(2.6, 2),
                        FlSpot(4.9, 5),
                        FlSpot(6.8, 3.1),
                        FlSpot(8, 4),
                        FlSpot(9.5, 3),
                        FlSpot(11, 4),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Bar Chart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: true),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: Colors.red)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: Colors.green)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: Colors.blue)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: Colors.orange)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 13, color: Colors.purple)]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
