import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthWebservice {
  Future<Map<String , dynamic>> authenticate(String email, String password , String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyBTSNwQJLBiq5nq0yebvRzRPBTBkf9qBOM';
    try {
      final posted = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final response = json.decode(posted.body);
      return response;
    } catch (error) {
      return {'' : ''};
    }
  }


}
