import 'dart:convert';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:http/http.dart' as http;

class ClassScheduleWebService {
  final Sharedprefs sharedprefs;

  ClassScheduleWebService(this.sharedprefs);

  Future<bool> addScheduleData( String classTime, String day, String subject,) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final month = DateTime.now().month;

    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/monthlyTimeTable/$uid/$month.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'classTime': classTime,
            'day': day,
            'subject': subject,
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveScheduleData() async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final month = DateTime.now().month;

    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/monthlyTimeTable/$uid/$month.json';
    try {
      final response = await http.get(Uri.parse(url));

      final data = json.decode(response.body);
      if (data != null) {
        return data;
      } else {
        return {};
      }
    } catch (error) {
      rethrow;
    }
  }
}
