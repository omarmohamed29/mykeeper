import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mokhatat/data/model/habits/habit_point_model.dart';
import 'package:mokhatat/data/model/habits/habit_tracker_model.dart';

import 'package:mokhatat/data/repository/HabitTrackerRepository.dart';

part 'habit_tracker_state.dart';

class HabitTrackerCubit extends Cubit<HabitTrackerState> {
  final HabitTrackerRepo habitTrackerRepo;
  HabitTrackerCubit(
    this.habitTrackerRepo,
  ) : super(HabitTrackerInitial());

  Future<void> uploadHabitState(
      List<HabitPointModel> habitPoints, String date) async {
    await habitTrackerRepo.addHabits(habitPoints, date).then((response) {
      if (response) {
        emit(HabitTrackerError('Something went wrong try again later'));
      } else {
        emit(HabitTrackerUploaded('Habit uploaded successfully'));
      }
    });
  }

  Future<void> retrieveHabits() async {
    await habitTrackerRepo.retrieveHabits().then((habits) {
      if (habits.isEmpty) {
        emit(HabitTrackerInitial());
      } else {
        emit(HabitTrackerRetrieved(habitTracker: habits as List<HabitTrackerModel>));
      }
    });
  }
}
