import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mokhatat/data/repository/shared_prefs.dart';

class UserWebservice {
  final Sharedprefs sharedprefs;

  UserWebservice(this.sharedprefs);
  Future<bool> addUser(
      String name, String address, String email, String phoneNumber) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/users/$uid.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'name': name,
            'address': address,
            'email': email,
            'phoneNumber': phoneNumber
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

  Future<dynamic> retrieveUser() async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/users/$uid.json';

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
