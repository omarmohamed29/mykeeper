part of 'add_habit_cubit.dart';

@immutable
abstract class AddHabitState {}

class AddHabitInitial extends AddHabitState {}


class HabitsError  extends AddHabitState{
   final String error;

  HabitsError(this.error);
}

class HabitsUploaded extends AddHabitState{
  final String  succeed;

  HabitsUploaded(this.succeed); 

}
class HabitsEdited extends AddHabitState{
  final String  succeed;

  HabitsEdited(this.succeed); 

}


class AllHabitsRetrieved extends AddHabitState{
  final List<Habit> habits;

  AllHabitsRetrieved(this.habits);
}