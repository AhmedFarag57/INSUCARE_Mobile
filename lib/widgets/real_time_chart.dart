import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RealTimeChartWidget extends StatelessWidget {
  const RealTimeChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 320.0,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 15,
          minY: 0,
          maxY: 15,
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 4),
                const FlSpot(1, 6),
                const FlSpot(2, 8),
                const FlSpot(3, 6.5),
                const FlSpot(4, 6),
                const FlSpot(5, 8),
                const FlSpot(6, 9),
                const FlSpot(7, 7),
                const FlSpot(8, 6),
                const FlSpot(9, 8),
                const FlSpot(10, 4),
                const FlSpot(11, 6),
                const FlSpot(12, 8),
                const FlSpot(13, 6.5),
                const FlSpot(14, 6),
                const FlSpot(15, 8),
              ],
              isCurved: true,
              gradient: const LinearGradient(
                colors: [
                  Color(0xff23b6e6),
                  Color(0xff02d39a),
                ],
              ),
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff23b6e6).withOpacity(0.3),
                    const Color(0xff02d39a).withOpacity(0.3),
                  ],
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white,
                strokeWidth: 0.8,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  switch (value.toInt()) {
                    case 0:
                      text = "0";
                      break;
                    case 2:
                      text = "2";
                      break;
                    case 4:
                      text = "4";
                      break;
                    case 6:
                      text = "6";
                      break;
                    case 8:
                      text = "8";
                      break;
                    case 10:
                      text = "10";
                      break;
                    case 12:
                      text = "12";
                      break;
                    case 14:
                      text = "14";
                      break;
                    default:
                      return Container();
                  }
                  return Text(
                    text,
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  switch (value.toInt()) {
                    case 0:
                      text = "0.0";
                      break;
                    case 2:
                      text = "0.2";
                      break;
                    case 4:
                      text = "0.4";
                      break;
                    case 6:
                      text = "0.6";
                      break;
                    case 8:
                      text = "0.8";
                      break;
                    case 10:
                      text = "1.0";
                      break;
                    case 12:
                      text = "1.2";
                      break;
                    case 14:
                      text = "1.4";
                      break;
                    default:
                      return Container();
                  }
                  return Text(
                    "  $text",
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  String status = '';
                  switch (value.toInt()) {
                    case 2:
                      text = "3";
                      status = "am";
                      break;
                    case 4:
                      text = "6";
                      status = "am";
                      break;
                    case 6:
                      text = "9";
                      status = "am";
                      break;
                    case 8:
                      text = "12";
                      status = "pm";
                      break;
                    case 10:
                      text = "3";
                      status = "pm";
                      break;
                    case 12:
                      text = "6";
                      status = "pm";
                      break;
                    case 14:
                      text = "9";
                      status = "pm";
                      break;
                    case 16:
                      text = "12";
                      status = "am";
                      break;
                    default:
                      return Container();
                  }
                  return Column(
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Ubuntu',
                          height: 1,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
