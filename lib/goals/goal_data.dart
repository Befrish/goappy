import 'package:flutter/foundation.dart';

enum GoalState {
  planned,
  focused,
  done,
}

class Goal {
  String name;
  String? imageUrl;

  GoalState state;

  // Priority -> List Order!
  // If done, no priority. Use done datetime instead.

  Goal({
    required this.name,
    this.imageUrl,
    this.state = GoalState.planned,
  });
}

class Goals extends ChangeNotifier {
  final GoalRepository goalRepository;
  List<Goal> _goals = [];

  Goals(this.goalRepository) {
    fetchAllGoals();
  }

  List<Goal> get goals => []..addAll(_goals);

  List<Goal> goalsByState(GoalState state) {
    return goals.where((goal) => goal.state == state).toList();
  }

  void fetchAllGoals() {
    _goals = goalRepository.findAll();
    notifyListeners();
  }

  void addGoal(Goal goal) {
    if (!_goals.contains(goal)) {
      _goals.add(goal);
      notifyListeners();
    }
  }

  void replaceGoal(Goal goal) {
    if (_goals.contains(goal)) {
      final int index = _goals.indexOf(goal);
      _goals.removeAt(index);
      _goals.insert(index, goal);
      notifyListeners();
    }
  }

  void removeGoal(Goal goal) {
    if (_goals.contains(goal)) {
      _goals.remove(goal);
      notifyListeners();
    }
  }
}

abstract class GoalRepository {
  List<Goal> findAll();
  List<Goal> findAllByState(GoalState state);
  void save(Goal goal);
  void delete(Goal goal);
}

class DemoDataGoalRepository extends GoalRepository {
  static final List<Goal> _goals = [
    Goal(
      name: 'Ziel 1',
      imageUrl: 'https://image.geo.de/30140170/t/AV/v3/w960/r0/-/nordlichter-f-216939353-jpg--79714-.jpg',
      state: GoalState.focused,
    ),
    Goal(name: 'Ziel 2   Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla', state: GoalState.focused),
    Goal(name: 'Ziel 3'),
    Goal(
      name: 'Ziel 4',
      imageUrl: 'https://pendix.de/media/Default/_processed_/c/b/csm_01_Vor_der_Reise_web_5a59884919.jpg',
      state: GoalState.focused,
    ),
    Goal(name: 'Ziel 5'),
    Goal(name: 'Ziel 6'),
    Goal(
      name: 'Ziel 7',
      state: GoalState.done,
    ),
    Goal(
      name: 'Ziel 8',
      imageUrl: 'https://www.uni-rostock.de/storages/uni-rostock/UniHome/Presse/Pressemeldungen/Wellensittiche_fuettern.JPG',
      state: GoalState.focused,
    ),
    Goal(
      name: 'Ziel 9',
      state: GoalState.done,
    ),
    Goal(name: 'Ziel 10'),
  ];

  @override
  List<Goal> findAll() {
    return []..addAll(_goals);
  }

  @override
  List<Goal> findAllByState(GoalState state) {
    return findAll().where((goal) => goal.state == state).toList();
  }

  @override
  void save(Goal goal) {
    final int index = _goals.indexOf(goal);
    if (index >= 0) {
      _goals.removeAt(index);
      _goals.insert(index, goal);
    } else {
      _goals.add(goal);
    }
  }

  @override
  void delete(Goal goal) {
    _goals.remove(goal);
  }
}
