import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WidgetDonutChart extends StatelessWidget {
  final List<DonutData> data;
  final double centerSpaceRadius;
  final String? centerText;
  final String? commentText;

  const WidgetDonutChart({
    super.key,
    required this.data,
    this.centerSpaceRadius = 60,
    this.centerText,
    this.commentText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            startDegreeOffset: -90,
            sectionsSpace: 4,
            centerSpaceRadius: centerSpaceRadius,
            sections: data.map((e) {
              return PieChartSectionData(
                color: e.color,
                value: e.value,
                title: '',
                radius: e.radius ?? 20,
                titleStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
        if (centerText != null) ...[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                centerText!,
                style: TextStyle(
                  color: const Color(0xFF2B2F35),
                  fontSize: 24,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (commentText != null) ...[
                Text(
                  commentText!,
                  style: TextStyle(
                    color: const Color(0xFF319877),
                    fontSize: 14,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          )
        ],
      ],
    );
  }
}

class DonutData {
  final double value;
  final Color color;
  final bool showTitle;
  final double? radius;

  DonutData({
    required this.value,
    required this.color,
    this.showTitle = true,
    this.radius,
  });
}