import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:goappy/achievement_journal/achievement_journal_entry_data.dart';

// Swiper: https://www.youtube.com/watch?v=Ng-QQ6-9AJI
// https://pub.dev/packages/flutter_swiper
// https://flutter.dev/docs/cookbook/forms/text-field-changes
// https://pub.dev/packages/table_calendar -> Wöchentlichen Kalender einblenden

class AchievementJournalEntryPage extends StatefulWidget {
  final AchievementJournalEntry achievementJournalEntry;

  const AchievementJournalEntryPage(this.achievementJournalEntry);

  _AchievementJournalEntryPageState createState() => _AchievementJournalEntryPageState();
}

class _AchievementJournalEntryPageState extends State<AchievementJournalEntryPage> {
  List<String> _achievements = [];

  @override
  void initState() {
    super.initState();
    _achievements = []..addAll(widget.achievementJournalEntry.achievements);
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              '${formatter.format(widget.achievementJournalEntry.date.toDateTime())}',
              style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: _achievementsList(),
          ),
          _addAchievementButton(),
        ],
      ),
    );
  }

  Widget _achievementsList() {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _achievements.length,
      itemBuilder: (BuildContext context, int index) => Slidable(
        key: ValueKey(index),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        child: AchievementListItem(_achievements[index]),
        actions: <Widget>[
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.red,
            onTap: () {
              setState(() {
                _achievements.removeAt(index);
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
          final String achievement = _achievements.removeAt(oldIndex);
          _achievements.insert(newIndex, achievement);
        });
      },
    );
  }

  Widget _addAchievementButton() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _achievements.add('TEST'); // TODO
          });
        },
      ),
    );
  }
}

class AchievementListItem extends StatelessWidget {
  final String achievement;

  const AchievementListItem(
    this.achievement, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(right: 32),
        child: ListTile(
          leading: Icon(Icons.stars),
          title: Text(achievement), // TODO TextField(),
        ),
      ),
    );
  }
}
