part of 'goal_cubit.dart';

@immutable
abstract class GoalState {}

class GoalInitial extends GoalState {}

class GoalRetrieved extends GoalState {
  final List<Goal> goal;

  GoalRetrieved(this.goal);
}

class GoalError extends GoalState {
  final String error;

  GoalError(this.error);
}

class GoalDataEdit extends GoalState {
  final String response;

  GoalDataEdit(this.response);
}

class GoalDataAdded extends GoalState {
  final String response;

  GoalDataAdded(this.response);
}

class GoalDataDeleted extends GoalState {
  final String response;

  GoalDataDeleted(this.response);
}