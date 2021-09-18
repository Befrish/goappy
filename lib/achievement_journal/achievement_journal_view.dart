import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:goappy/app/app_page_data.dart';
import 'package:goappy/achievement_journal/achievement_journal_entry_data.dart';
import 'package:goappy/achievement_journal/achievement_journal_entry.dart';

class AchievementJournalPageData extends AppPageData {
  AchievementJournalPageData()
      : super(
          title: 'Erfolgstagebuch',
          icon: const Icon(Icons.menu_book_rounded),
          contentBuilder: (context) => AchievementJournalPage(
            DemoDataAchievementJournalEntryRepository().findAll(),
          ),
          actionBuilders: <WidgetBuilder>[
            (context) => IconButton(
                  icon: Icon(Icons.today_rounded),
                  onPressed: () {}, // TODO add entry for today if not present and show today
                ),
          ],
        );
}

class AchievementJournalPage extends StatelessWidget {
  final List<AchievementJournalEntry> achievementJournalEntries;

  const AchievementJournalPage(this.achievementJournalEntries);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Swiper(
            itemCount: achievementJournalEntries.length,
            itemBuilder: (BuildContext context, int index) {
              return AchievementJournalEntryPage(achievementJournalEntries[index]);
            },
            control: SwiperControl(),
            loop: false,
            index: achievementJournalEntries.length - 1,
          ),
        ),
      ],
    );
  }
}
