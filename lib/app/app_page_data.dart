import 'package:flutter/material.dart';

class AppPageData {
  final String title;
  final Widget icon;
  final WidgetBuilder contentBuilder;
  final List<WidgetBuilder> actionBuilders;

  const AppPageData({
    required this.title,
    required this.icon,
    required this.contentBuilder,
    this.actionBuilders = const <WidgetBuilder>[],
  });

  List<Widget> actions(BuildContext context) {
    return actionBuilders.map((actionBuilder) => actionBuilder(context)).toList();
  }
}
