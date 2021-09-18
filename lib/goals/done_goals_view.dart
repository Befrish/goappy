import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:goappy/app/app_page_data.dart';
import 'package:goappy/goals/goal_data.dart';
import 'package:goappy/goals/goal_state_icon.dart';
import 'package:goappy/goals/goals_statistics.dart';

class DoneGoalsPageData extends AppPageData {
  DoneGoalsPageData()
      : super(
          title: 'Geschaffte Ziele',
          icon: Icon(Icons.flag_outlined),
          contentBuilder: (context) => DoneGoalsPage(DemoDataGoalRepository()),
        );
}

class DoneGoalsPage extends StatefulWidget {
  final GoalRepository goalRepository;

  DoneGoalsPage(this.goalRepository);

  _DoneGoalsPageState createState() => _DoneGoalsPageState();
}

class _DoneGoalsPageState extends State<DoneGoalsPage> {
  List<Goal> _goals = [];

  @override
  void initState() {
    super.initState();
    _goals = widget.goalRepository.findAllByState(GoalState.done);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: GoalsStatistics(
            GoalsStatisticsData(_goals),
            statisticValues: <GoalsStatisticValueData>[
              GoalsStatisticValueData(
                title: 'Gesamt',
                icon: Icons.subject_rounded,
                valueBuilder: (context, statisticsData) => Text('${statisticsData.count()}'),
              ),
            ],
          ),
        ),
        Expanded(child: _goalsList()),
      ],
    );
  }

  Widget _goalsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _goals.length,
      itemBuilder: (BuildContext context, int index) => Slidable(
        key: ValueKey(index),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        child: DoneGoalListItem(_goals[index]),
        actions: <Widget>[
          IconSlideAction(
            icon: GoalStateIcon.plannedGoalIcon,
            color: GoalStateIcon.plannedGoalIconColor,
            onTap: () {
              setState(() {
                final Goal goal = _goals[index];
                goal.state = GoalState.planned;
                widget.goalRepository.save(goal);
                _goals.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }
}

class DoneGoalListItem extends StatelessWidget {
  final Goal goal;

  DoneGoalListItem(
    this.goal, {
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: GoalStateIcon(goal.state),
        title: Text(goal.name),
      ),
    );
  }
}
