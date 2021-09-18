import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:goappy/app/app_constants.dart';
import 'package:goappy/app/app_theme.dart';
import 'package:goappy/app/app_page.dart';
import 'package:goappy/goals/goal_data.dart';

// Bloc:
// bloc https://pub.dev/packages/bloc
// flutter_bloc https://pub.dev/packages/flutter_bloc
// https://bloclibrary.dev/#/gettingstarted
// -> https://blog.codemagic.io/flutter-state-management-with-riverpod/
// -> https://codewithandrea.com/videos/flutter-state-management-riverpod/

void main() {
  final goalsProvider = ChangeNotifierProvider((ref) => Goals(DemoDataGoalRepository()));

  runApp(
    ProviderScope(
      child: GoappyApp(),
    ),
  );
}

class GoappyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.name,
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.themeMode,
      darkTheme: AppTheme.darkTheme,
      home: RootAppPage(AppConstants.rootPages),
    );
  }
}

// https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/
