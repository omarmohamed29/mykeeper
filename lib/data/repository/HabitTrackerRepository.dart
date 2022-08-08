import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mokhatat/data/model/habits/habit_point_model.dart';
import 'package:mokhatat/data/model/habits/habit_tracker_model.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/webservice/HabitTreacker_webService.dart';

class HabitTrackerRepo {
  final Sharedprefs sharedPrefs;
  final HabitTrackerWebService habitTrackerWebService;

  HabitTrackerRepo(
    this.sharedPrefs,
    this.habitTrackerWebService,
  );

  Future<bool> addHabits(
      List<HabitPointModel> habitPoints, String date) async {
    final prefs = await sharedPrefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/habitTracker/$uid.json';

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'month': date,
            'habitPoints': habitPoints
                .map((e) => {
                      'vertical': e.verticalPoint,
                      'horizontal': e.horizontalPoint,
                      'status': e.status
                    })
                .toList()
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

  Future<List<dynamic>> retrieveHabits() async {
    final habitsRetrieved = await habitTrackerWebService.retrieveHabits();
    if(habitsRetrieved.isEmpty){
        return [];
    }else{
    final List<HabitTrackerModel> habits = [];
    List<HabitTrackerModel> retrievedHabits = [];
    habitsRetrieved.forEach((habitId, habit) {
      habits.add(HabitTrackerModel(
          month: habit['month'],
          habitPoint: (habit['habitPoints'] as List<dynamic>)
              .map((habitPoint) => HabitPointModel(
                  verticalPoint: habitPoint['vertical'],
                  horizontalPoint: habitPoint['horizontal'],
                  status: habitPoint['status']))
              .toList()));
    });
    retrievedHabits = habits;
    return retrievedHabits;
    }
  }
}
