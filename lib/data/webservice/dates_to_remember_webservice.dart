import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mokhatat/data/repository/shared_prefs.dart';

class DatesToRememberWebService {
  final Sharedprefs sharedPrefs;

  DatesToRememberWebService(this.sharedPrefs);

  Future<bool> addDateToRemember(List<String>events , DateTime date) async {
    final prefs = await sharedPrefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/datesToRemember/$uid.json';

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'date': date.toIso8601String(),
            'events': events,
          }));
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveDates()async{
     final prefs = await sharedPrefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/datesToRemember/$uid.json';
    try{
        final response = await http.get(Uri.parse(url));

        final data = json.decode(response.body);
        if (data != null) {
        return data;
      } else {
        return {};
      }
    }catch(error){
      rethrow;
    }
  }
}
