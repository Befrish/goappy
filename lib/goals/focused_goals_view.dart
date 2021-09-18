import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:goappy/app/app_page_data.dart';
import 'package:goappy/app/app_page.dart';
import 'package:goappy/app/app_hint.dart';
import 'package:goappy/goals/goal_data.dart';
import 'package:goappy/goals/goal_state_icon.dart';
import 'package:goappy/goals/planned_goals_view.dart';
import 'package:goappy/goals/done_goals_view.dart';
import 'package:goappy/goals/goals_statistics.dart';

const int _recommendedFocusedGoalsCount = 3;

class FocusedGoalsPageData extends AppPageData {
  FocusedGoalsPageData()
      : super(
          title: 'Aktuelle Ziele',
          icon: Icon(Icons.flag_rounded),
          contentBuilder: (context) => FocusedGoalsPage(
            DemoDataGoalRepository().findAllByState(GoalState.focused),
          ),
          actionBuilders: <WidgetBuilder>[
            _plannedGoalsIconButton,
            _doneGoalsIconButton,
          ],
        );

  static Widget _plannedGoalsIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.receipt_long),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubAppPage(PlannedGoalsPageData()),
          ),
        );
      },
    ); // TODO Update nach dem zurückkommen
    // https://medium.com/codechai/architecting-your-flutter-project-bd04e144a8f1
  }

  static Widget _doneGoalsIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.emoji_events_rounded),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubAppPage(DoneGoalsPageData()),
          ),
        );
      },
    );
  }
}

class FocusedGoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final List<Goal> goals = ref.watch(goalsProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: GoalsStatistics(
                GoalsStatisticsData(goals),
                statisticValues: <GoalsStatisticValueData>[
                  GoalsStatisticValueData(
                    title: 'Gesamt',
                    icon: Icons.subject_rounded,
                    valueBuilder: (context, statisticsData) => Text('${statisticsData.count()}'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _moreGoalsThanRecommendedHint(),
            ),
            Expanded(child: _goalsList(goals)),
          ],
        );
      },
    );
  }

  Widget _moreGoalsThanRecommendedHint(List<Goal> goals) {
    if (_goals.length > _recommendedFocusedGoalsCount) {
      return AppWarningCard(
        Text('Du hast mehr als $_recommendedFocusedGoalsCount aktuelle Ziele. Es ist sinnvoller sich auf weniger Ziele zu konzentrieren, um diese Ziele besser und schneller erreichen zu können.'),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _goalsList(List<Goal> goals) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _goals.length,
      itemBuilder: (BuildContext context, int index) => Slidable(
        key: ValueKey(index),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        child: FocusedGoalListItem(_goals[index]),
        actions: <Widget>[
          IconSlideAction(
            icon: GoalStateIcon.plannedGoalIcon,
            color: GoalStateIcon.plannedGoalIconColor,
            onTap: () {
              setState(() {
                _goals[index].state = GoalState.planned;
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
}

class FocusedGoalListItem extends StatelessWidget {
  final Goal goal;

  FocusedGoalListItem(
    this.goal, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 32),
            child: ListTile(
              leading: GoalStateIcon(goal.state),
              title: Text(
                goal.name,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 32,
              bottom: 8,
            ),
            child: _imageOrHint(context),
          ),
        ],
      ),
    );
  }

  Widget _imageOrHint(BuildContext context) {
    if (goal.imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: goal.imageUrl!,
        progressIndicatorBuilder: (context, url, downloadProgress) => LinearProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => AppHintText('Das Bild konnte nicht geladen werden. Bitte stelle eine Internetverbindung her.'),
        //fit: BoxFit.contain,
        //filterQuality: FilterQuality.medium,
      );
    } else {
      return AppHintText('Nutze ein Bild zur Visualisierung des Ziels!');
    }
  }
}
