part of 'budget_cubit.dart';

@immutable
abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetRetrieved extends BudgetState{
  final Budget budget;

  BudgetRetrieved(this.budget);
}

class BudgetError extends BudgetState{
  final String error;

  BudgetError(this.error);
}

class BudgetDataEdit extends BudgetState{
  final String response;

  BudgetDataEdit(this.response);

}

class BudgetDataAdded extends BudgetState{
  final String response;

  BudgetDataAdded(this.response);
}
