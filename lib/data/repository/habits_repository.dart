import 'dart:developer';

import 'package:mokhatat/data/model/habits/habit_model.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/webservice/habit_webService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HabitsRepo{
  final HabitWebService habitWebService ;
    final Sharedprefs sharedPrefs;

  HabitsRepo(this.habitWebService, this.sharedPrefs);

  Future<bool> addHabits(List<String> habits, int month) async {
    final prefs = await sharedPrefs.retrieveData();
    final uid = prefs['userId'];
    final url =
        'https://mokhatat-12b5e-default-rtdb.europe-west1.firebasedatabase.app/habits/$uid.json';

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'habits': habits,
            'month' : month
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

  Future<dynamic> retrieveHabits() async {
    final habitsRetrieved = await habitWebService.retrieveHabits();
    if(habitsRetrieved.isEmpty){
        return {};
    }else{
    final List<Habit> habits = [];
    List<Habit> retrievedHabits = [];
    habitsRetrieved.forEach((habitId, habit) {
      habits.add(Habit(habits: habit['habits'], month: habit['month']));
    });
    retrievedHabits = habits;
    return retrievedHabits;
    }
  }
}