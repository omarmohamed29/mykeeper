import 'package:mokhatat/data/model/habits/habit_point_model.dart';

class HabitTrackerModel {
  late final String month;
  late final List<HabitPointModel> habitPoint;

  HabitTrackerModel({
    required this.month,
    required this.habitPoint,
  });
}
