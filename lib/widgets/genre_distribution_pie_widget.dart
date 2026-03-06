import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GenreDistributionPie extends StatelessWidget {
  final Map<String, double> genreData;

  const GenreDistributionPie({
    super.key,
    required this.genreData,
  });

  List<PieChartSectionData> _buildSections() {
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.teal,
    ];

    int i = 0;

    return genreData.entries.map((entry) {
      final section = PieChartSectionData(
        color: colors[i % colors.length],
        value: entry.value,
        title: '${entry.key}\n${entry.value.toStringAsFixed(0)}%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );

      i++;
      return section;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Genre Distribution',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sections: _buildSections(),
              sectionsSpace: 3,
              centerSpaceRadius: 40,
            ),
          ),
        ),
      ],
    );
  }
}
