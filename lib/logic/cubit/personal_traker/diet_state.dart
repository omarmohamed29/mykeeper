part of 'diet_cubit.dart';

@immutable
abstract class DietState {}

class DietInitial extends DietState {}

class DietRetrieved extends DietState{
  final Diet diet;

  DietRetrieved(this.diet);
}

class DietError extends DietState{
  final String error;

  DietError(this.error);
}

class DietDataEdit extends DietState{
  final String response;

  DietDataEdit(this.response);

}

class DietDataAdded extends DietState{
  final String response;

  DietDataAdded(this.response);
}
