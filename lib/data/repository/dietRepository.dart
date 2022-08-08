import 'dart:convert';
import 'package:mokhatat/data/model/personal_keeper/diet.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/webservice/dietWebService.dart';

class DietRepo {
  final Sharedprefs sharedprefs;
  final DietWebService dietWebService;

  DietRepo(
    this.sharedprefs,
    this.dietWebService,
  );

  Future<dynamic> retrieveData() async {
    final retrievedData = await dietWebService.retrieveData();
    if (retrievedData.isEmpty) {
      return {};
    } else {
      final data = Diet.fromJson(retrievedData);
      return data;
    }
  }
}
