import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mokhatat/data/model/goal.dart';
import 'package:mokhatat/data/repository/goal_repository.dart';
import 'package:mokhatat/data/webservice/goal_webservice.dart';

part 'goal_state.dart';

class GoalCubit extends Cubit<GoalState> {
  final GoalWebService goalWebService;
  final GoalRepo goalRepo;
  GoalCubit(
    this.goalWebService,
    this.goalRepo,
  ) : super(GoalInitial());

  Future<void> retrieveGoalfData() async {
    await goalRepo.retrieveData().then((data) {
      if (data.toString() == {}.toString()) {
        emit(GoalError('you havent set your goals yet!'));
      } else {
        emit(GoalInitial());
        emit(GoalRetrieved(data));
      }
    });
  }

  Future<void> addBookshelfData(
      String goal, bool status, String category) async {
    await goalWebService.addGoalData(goal, status, category).then((response) {
      if (response) {
        emit(GoalDataAdded('your Goal data has been added successfully'));
      } else {
        emit(GoalError('Something went wrong please try again later'));
      }
    });
  }

  Future<void> editBookshelfData(
      String goal, bool status, String category , String id) async {
    await goalWebService.editGoalData(goal, status, category , id).then((response) {
      if (response) {
        emit(GoalDataEdit('your goal data has been edited successfully'));
      } else {
        emit(GoalError('Something went wrong please try again later'));
      }
    });
  }

  Future<void> deleteBookshelfData(String id) async {
    await goalWebService.deleteGoal(id).then((response) {
      if (response) {
        emit(GoalDataDeleted('Goal deleted successfully'));
      } else {
        emit(GoalError('Something went wrong please try again later'));
      }
    });
  }
}
