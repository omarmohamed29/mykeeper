part of 'habit_tracker_cubit.dart';

@immutable
abstract class HabitTrackerState {}

class HabitTrackerInitial extends HabitTrackerState {}

class HabitTrackerUploaded extends HabitTrackerState {
  final String succeed;

  HabitTrackerUploaded(this.succeed);
}

class HabitTrackerError extends HabitTrackerState {
  final String error;

  HabitTrackerError(this.error);
}

class HabitTrackerRetrieved extends HabitTrackerState {
  final List<HabitTrackerModel> habitTracker;
  HabitTrackerRetrieved({
    required this.habitTracker,
  });
}
