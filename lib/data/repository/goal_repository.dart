import 'package:mokhatat/data/model/goal.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/webservice/goal_webservice.dart';

class GoalRepo {
  final Sharedprefs sharedprefs;
  final GoalWebService goalWebService;

  GoalRepo(this.sharedprefs, this.goalWebService);

  Future<dynamic> retrieveData() async {
    final retrievedData = await goalWebService.retrieveGoalData();
    if (retrievedData.isEmpty) {
      return {};
    } else {
      List<Goal> getData = [];
      List<Goal> goal = [];
      retrievedData.forEach((id, value) {
        getData.add(Goal(
          id: id,
          goal: value['goal'],
          status: value['status'],
          category: value['category'],
        ));
      });
      goal = getData.toList();
      return goal;
    }
  }
}
