import 'dart:convert';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:http/http.dart' as http;

class HabitTrackerWebService {
  final Sharedprefs sharedPrefs;

  HabitTrackerWebService(this.sharedPrefs);

  Future<Map<String, dynamic>> retrieveHabits() async {
    final prefs = await sharedPrefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/habitTracker/$uid.json';
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
