import 'package:goappy/app/app_page_data.dart';
import 'package:goappy/goals/focused_goals_view.dart';
import 'package:goappy/achievement_journal/achievement_journal_view.dart';

class AppConstants {
  static const String name = "goappy";

  static final List<AppPageData> rootPages = [
    FocusedGoalsPageData(),
    AchievementJournalPageData(),
  ];
}
