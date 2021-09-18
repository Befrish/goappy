import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:goappy/app/app_page_data.dart';
import 'package:goappy/goals/goal_data.dart';
import 'package:goappy/goals/goal_state_icon.dart';
import 'package:goappy/goals/goals_statistics.dart';

class PlannedGoalsPageData extends AppPageData {
  PlannedGoalsPageData()
      : super(
          title: 'Geplante Ziele',
          icon: Icon(Icons.flag_outlined),
          contentBuilder: (context) => PlannedGoalsPage(
            DemoDataGoalRepository().findAllByState(GoalState.planned),
          ),
        );
}

class PlannedGoalsPage extends StatefulWidget {
  final List<Goal> goals;

  PlannedGoalsPage(this.goals);

  _PlannedGoalsPageState createState() => _PlannedGoalsPageState();
}

class _PlannedGoalsPageState extends State<PlannedGoalsPage> {
  List<Goal> _goals = [];

  @override
  void initState() {
    super.initState();
    _goals = []..addAll(widget.goals);
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
              /*GoalsStatisticValueData(
                title: 'Gesamt',
                icon: Icons.subject_rounded,
                valueBuilder: (context, statisticsData) => Text('${statisticsData.count()}'),
              ),*/
            ],
          ),
        ),
        _addGoalButton(0),
        Expanded(child: _goalsList()),
        _addGoalButton(_goals.length),
      ],
    );
  }

  Widget _goalsList() {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _goals.length,
      itemBuilder: (BuildContext context, int index) => Slidable(
        key: ValueKey(index),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        child: PlannedGoalListItem(_goals[index]),
        actions: <Widget>[
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.red,
            onTap: () {
              setState(() {
                _goals.removeAt(index);
              });
            },
          ),
          IconSlideAction(
            icon: GoalStateIcon.focusedGoalIcon,
            color: GoalStateIcon.focusedGoalIconColor,
            onTap: () {
              setState(() {
                _goals[index].state = GoalState.focused;
                _goals.removeAt(index);
              });
            },
          ),
        ],
      ),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Goal goal = _goals.removeAt(oldIndex);
          _goals.insert(newIndex, goal);
        });
      },
    );
  }

  Widget _addGoalButton(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _goals.insert(
              index,
              Goal(name: 'TEST'), // TODO
            );
          });
        },
      ),
    );
  }
}

class PlannedGoalListItem extends StatelessWidget {
  final Goal goal;

  PlannedGoalListItem(
    this.goal, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: GoalStateIcon(goal.state),
        title: Text(goal.name),
      ),
    );
  }
}
