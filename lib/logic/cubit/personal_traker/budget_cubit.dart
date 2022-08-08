import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mokhatat/data/model/personal_keeper/budget.dart';

import 'package:mokhatat/data/repository/budgetRepository.dart';
import 'package:mokhatat/data/webservice/budget_webService.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final BudgetWebService budgetWebService;
  final BudgetRepo budgetRepo;
  BudgetCubit(
    this.budgetWebService,
    this.budgetRepo,
  ) : super(BudgetInitial());

  Future<void> retrieveBudgetData() async {
    await budgetRepo.retrieveData().then((data) {
      if (data.toString() == {}.toString()) {
        emit(BudgetError('you havent set your budget yet!'));
      } else if (data.toString() != {}.toString() &&
          int.parse((data).month) != DateTime.now().month) {
        emit(BudgetError('you havent set your budget for the new month yet!'));
      } else {
        emit(BudgetInitial());
        emit(BudgetRetrieved(data));
      }
    });
  }

  Future<void> addBudgetData(
      String incomingMoney, String spentMoney, String month) async {
    await budgetWebService
        .addBudgetData(incomingMoney, spentMoney, month)
        .then((response) {
      if (response) {
        emit(BudgetDataAdded('your Budget data has been added successfully'));
      } else {
        emit(BudgetError('Something went wrong please try again later'));
      }
    });
  }

  Future<void> editBudgetData(
      String incomingMoney, String spentMoney, String month) async {
    await budgetWebService
        .editBudgetData(incomingMoney, spentMoney, month)
        .then((response) {
      if (response) {
        emit(BudgetDataEdit('your Budget data has been edited successfully'));
      } else {
        emit(BudgetError('Something went wrong please try again later'));
      }
    });
  }
}
