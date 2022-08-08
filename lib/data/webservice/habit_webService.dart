// ignore: file_names
import 'dart:convert';

import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:http/http.dart' as http;

class HabitWebService{
  final Sharedprefs sharedprefs;

  HabitWebService(this.sharedprefs);

   Future<Map<String, dynamic>> retrieveHabits() async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/habits/$uid.json';
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