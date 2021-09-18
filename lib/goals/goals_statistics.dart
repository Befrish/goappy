import 'package:flutter/material.dart';

import 'package:goappy/goals/goal_data.dart';

class GoalsStatisticsData {
  final List<Goal> goals;

  const GoalsStatisticsData(this.goals);

  int count() => goals.length;
}

typedef GoalsStatisticValueBuilder = Widget Function(BuildContext context, GoalsStatisticsData statisticsData);

class GoalsStatisticValueData {
  final String title;
  final IconData icon;
  final GoalsStatisticValueBuilder valueBuilder;

  const GoalsStatisticValueData({
    required this.title,
    required this.icon,
    required this.valueBuilder,
  });
}

class GoalsStatistics extends StatelessWidget {
  final GoalsStatisticsData statisticsData;
  final List<GoalsStatisticValueData> statisticValues;

  const GoalsStatistics(
    this.statisticsData, {
    this.statisticValues = const <GoalsStatisticValueData>[],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[800], // TODO Theme
      child: Column(
        // TODO make responsive
        children: statisticValues.map<Widget>((statisticValue) {
          return ListTile(
            leading: Icon(statisticValue.icon),
            title: Text(statisticValue.title, style: Theme.of(context).textTheme.subtitle1), // TODO translation
            trailing: statisticValue.valueBuilder(context, statisticsData),
          );
        }).toList(),
      ),
    );
  }
}
