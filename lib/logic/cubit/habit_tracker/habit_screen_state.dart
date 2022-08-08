part of 'habit_screen_cubit.dart';

@immutable
abstract class HabitScreenState {}

class HabitScreenInitial extends HabitScreenState {}

class HabitsAddedLocally extends HabitScreenState {
  final String message;

  HabitsAddedLocally(this.message);
}

class HabitsRemovedLocally extends HabitScreenState {
  final String message;
  HabitsRemovedLocally({
    required this.message,
  });
}

class HabitsClearedLocally extends HabitScreenState {}


class HabitsRetrieved extends HabitScreenState {
  final List<HabitPointModel> localHabits;

  HabitsRetrieved(this.localHabits);
}
