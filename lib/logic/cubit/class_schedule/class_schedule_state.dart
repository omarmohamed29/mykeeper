part of 'class_schedule_cubit.dart';

@immutable
abstract class ClassScheduleState {}

class ClassScheduleInitial extends ClassScheduleState {}

class ClassScheduleRetrieved extends ClassScheduleState {
  final List<ClassScheduleModel> classes;

  ClassScheduleRetrieved(this.classes);
}

class ClassScheduleError extends ClassScheduleState {
  final String error;

  ClassScheduleError(this.error);
}

class ClassScheduleDataEdit extends ClassScheduleState {
  final String response;

  ClassScheduleDataEdit(this.response);
}

class ClassScheduleDataAdded extends ClassScheduleState {
  final String response;

  ClassScheduleDataAdded(this.response);
}

class ClassScheduleDataDeleted extends ClassScheduleState {
  final String response;

  ClassScheduleDataDeleted(this.response);
}