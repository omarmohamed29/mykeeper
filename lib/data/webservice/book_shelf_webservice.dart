import 'dart:convert';

import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:http/http.dart' as http;

class BookShelfWebService {
  final Sharedprefs sharedprefs;

  BookShelfWebService({
    required this.sharedprefs,
  });

  Future<bool> addBookData(
      String bookName, String author, String category) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/bookshelf/$uid.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'book_name': bookName,
            'author': author,
            'category': category,
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

  Future<bool> editBookData(
      String bookName, String author, String category , String id) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/bookshelf/$uid/$id.json';
    try {
      final response = await http.put(Uri.parse(url),
          body: json.encode({
            'book_name': bookName,
            'author': author,
            'category': category,
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

  Future<bool> deleteBook(String id) async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/bookshelf/$uid/$id.json';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> retrieveBook() async {
    final prefs = await sharedprefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/bookshelf/$uid.json';
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
