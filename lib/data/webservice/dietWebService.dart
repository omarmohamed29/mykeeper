import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DietWebService {
  final Sharedprefs sharedprefs;

  DietWebService(this.sharedprefs);

  Future<bool> addDietData(
      String startWeight, String targetWeight, String month) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/diet/$uid.json';
    try {
    final response = await  http.put(Uri.parse(url),
          body: json.encode({
            'startWeight': startWeight,
            'targetWeight': targetWeight,
            'month': month,
          }));
          if(response.statusCode == 200){
            return true;
          }else{
            return false;
          }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> editDietData(
      String startWeight, String targetWeight, String month) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/diet/$uid.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'startWeight': startWeight,
            'targetWeight': targetWeight,
            'month': month,
          }));
          if(response.statusCode == 200){
            return true;
          }else{
            return false;
          }
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveData() async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/diet/$uid.json';
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
