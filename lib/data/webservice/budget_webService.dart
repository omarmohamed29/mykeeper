import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BudgetWebService {
  final Sharedprefs sharedprefs;

  BudgetWebService(this.sharedprefs);

  Future<bool> addBudgetData(
      String incomingMoney, String spentMoney, String month) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/budget/$uid.json';
    try {
      final response = await http.put(Uri.parse(url),
          body: json.encode({
            'incoming': incomingMoney,
            'spent': spentMoney,
            'month': month,
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

  Future<bool> editBudgetData(
      String incomingMoney, String spentMoney, String month) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/budget/$uid.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'incoming': incomingMoney,
            'spent': spentMoney,
            'month': month,
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

  Future<Map<String, dynamic>> retrieveBudget() async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/budget/$uid.json';
    try {
      final response = await http.get(Uri.parse(url));

      final data = json.decode(response.body);
      if (data == null) {
        return {};
      } else {
        return data;
      }
    } catch (error) {
      rethrow;
    }
  }
}
