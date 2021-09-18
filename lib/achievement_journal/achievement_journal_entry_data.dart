import 'package:goappy/util/date.dart';

class AchievementJournalEntry {
  final Date date;
  final List<String> achievements;

  const AchievementJournalEntry({
    required this.date,
    this.achievements = const [],
  });
}

abstract class AchievementJournalEntryRepository {
  List<AchievementJournalEntry> findAll();
  bool existsAtDate(Date date);
  void save(AchievementJournalEntry achievementJournalEntry);
  void delete(AchievementJournalEntry achievementJournalEntry);
}

class DemoDataAchievementJournalEntryRepository extends AchievementJournalEntryRepository {
  static final List<AchievementJournalEntry> _achievementJournalEntries = [
    AchievementJournalEntry(
      date: Date(2021, 9, 1),
      achievements: [
        'Achievement 1.1',
        'Achievement 1.2',
        'Achievement 1.3',
      ],
    ),
    AchievementJournalEntry(
      date: Date(2021, 9, 2),
      achievements: [
        'Achievement 2.1',
        'Achievement 2.2',
        'Achievement 2.3',
      ],
    ),
    AchievementJournalEntry(
      date: Date(2021, 9, 3),
      achievements: [
        'Achievement 3.1',
      ],
    ),
    AchievementJournalEntry(
      date: Date(2021, 9, 4),
      achievements: [],
    ),
    AchievementJournalEntry(
      date: Date(2021, 9, 8),
      achievements: [
        'Achievement 8.1',
      ],
    ),
    AchievementJournalEntry(
      date: Date(2021, 9, 9),
    ),
    AchievementJournalEntry(
      date: Date(2021, 9, 10),
      achievements: [
        'Achievement 10.1 Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla',
        'Achievement 10.2',
        'Achievement 10.3',
        'Achievement 10.4',
        'Achievement 10.5',
        'Achievement 10.6',
        'Achievement 10.7',
        'Achievement 10.8',
        'Achievement 10.9',
        'Achievement 10.10',
      ],
    ),
    /*AchievementJournalEntry(
        date: Date.now(),
      ),*/
  ];

  @override
  List<AchievementJournalEntry> findAll() {
    return []..addAll(_achievementJournalEntries);
  }

  @override
  bool existsAtDate(Date date) {
    return findAll().any((entry) => entry.date == date);
  }

  @override
  void save(AchievementJournalEntry achievementJournalEntry) {
    final int index = _achievementJournalEntries.indexOf(achievementJournalEntry);
    if (index >= 0) {
      _achievementJournalEntries.removeAt(index);
      _achievementJournalEntries.insert(index, achievementJournalEntry);
    } else {
      _achievementJournalEntries.add(achievementJournalEntry);
    }
  }

  @override
  void delete(AchievementJournalEntry achievementJournalEntry) {
    _achievementJournalEntries.remove(achievementJournalEntry);
  }
}
