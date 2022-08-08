import 'package:mokhatat/data/model/dates_to_remember_model.dart';
import 'package:mokhatat/data/webservice/dates_to_remember_webservice.dart';

class DatesToRememberRepo {
  final DatesToRememberWebService datesToRememberWebService;

  DatesToRememberRepo(this.datesToRememberWebService);

  Future<dynamic> retrieveData() async {
    final retrievedData = await datesToRememberWebService.retrieveDates();
    if (retrievedData.isEmpty) {
      return {};
    } else {
      final List<DatesToRememberModel> allDates = [];
      List<DatesToRememberModel> retrievedDates = [];
      retrievedData.forEach((dateId, date) {
        allDates.add(DatesToRememberModel(
            date: DateTime.parse(date['date']),
            events: date['events'] as List<dynamic>));
      });
      retrievedDates = allDates.toList();
      return retrievedDates;
    }
  }
}
