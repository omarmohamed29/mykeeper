import 'package:mokhatat/data/model/personal_keeper/budget.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/webservice/budget_webService.dart';

class BudgetRepo {
  final Sharedprefs sharedprefs;
  final BudgetWebService budgetWebService;

  BudgetRepo(this.sharedprefs, this.budgetWebService);

  Future<dynamic> retrieveData() async {
    final retrievedData = await budgetWebService.retrieveBudget();
    if (retrievedData.isEmpty) {
      return {};
    } else {
      final data = Budget.fromJson(retrievedData);
      return data;
    }
  }
}
