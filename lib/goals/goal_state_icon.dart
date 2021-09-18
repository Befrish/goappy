import 'package:flutter/material.dart';

import 'package:goappy/goals/goal_data.dart';

class GoalStateIcon extends StatelessWidget {
  static final IconData plannedGoalIcon = Icons.next_plan_rounded;
  static final Color plannedGoalIconColor = Colors.lightBlue;
  static final IconData focusedGoalIcon = Icons.star_rounded;
  static final Color focusedGoalIconColor = Colors.yellow;
  static final IconData doneGoalIcon = Icons.check_circle_rounded;
  static final Color doneGoalIconColor = Colors.green;

  final GoalState goalState;
  final bool colored;

  const GoalStateIcon(
    this.goalState, {
    this.colored = true,
  });

  @override
  Widget build(BuildContext context) {
    switch (goalState) {
      case GoalState.planned:
        {
          return Icon(plannedGoalIcon, color: _iconColorOrDefaultByTheme(context, plannedGoalIconColor));
        }
      case GoalState.focused:
        {
          return Icon(focusedGoalIcon, color: _iconColorOrDefaultByTheme(context, focusedGoalIconColor));
        }
      case GoalState.done:
        {
          return Icon(doneGoalIcon, color: _iconColorOrDefaultByTheme(context, doneGoalIconColor));
        }
      default:
        {
          return Icon(Icons.help);
        }
    }
  }

  Color _iconColorOrDefaultByTheme(BuildContext context, Color iconColor) {
    return colored ? iconColor : (Theme.of(context).iconTheme.color ?? iconColor);
  }
}
