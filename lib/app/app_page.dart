import 'package:flutter/material.dart';

import 'package:goappy/app/app_page_data.dart';

class RootAppPage extends StatefulWidget {
  final List<AppPageData> rootPages;

  const RootAppPage(this.rootPages);

  _RootAppPageState createState() => _RootAppPageState();
}

class _RootAppPageState extends State<RootAppPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AppPageData _selectedPage = widget.rootPages[_selectedIndex];
    return Scaffold(
      appBar: AppBar(
        leading: _selectedPage.icon,
        title: Text(_selectedPage.title),
        actions: _selectedPage.actions(context),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.rootPages.map((page) => page.contentBuilder(context)).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).accentColor,
        items: widget.rootPages
            .map((page) => BottomNavigationBarItem(
                  icon: page.icon,
                  label: page.title,
                ))
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class SubAppPage extends StatelessWidget {
  final AppPageData page;

  const SubAppPage(this.page);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: page.icon, -> Back-Button!
        title: Text(page.title),
        actions: page.actions(context),
      ),
      body: page.contentBuilder(context),
    );
  }
}
