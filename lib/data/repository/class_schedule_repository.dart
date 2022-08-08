import 'dart:developer';

import 'package:mokhatat/data/model/time_table/class_schedule_model.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/webservice/class_schedule_webservice.dart';

class ClassScheduleRepo {
  final Sharedprefs sharedPrefs;
  final ClassScheduleWebService classScheduleWebService;

  ClassScheduleRepo(this.sharedPrefs, this.classScheduleWebService);
  Future<dynamic> retrieveclasses() async {
    final classesRetrieved =
        await classScheduleWebService.retrieveScheduleData();
    if (classesRetrieved.isEmpty) {
      return {};
    } else {
      List<ClassScheduleModel> classes = [];
      List<ClassScheduleModel> retrievedClasses = [];
      classesRetrieved.forEach((classId, classes) {
        retrievedClasses.add(ClassScheduleModel(
          classTime: classes['classTime'],
          day: classes['day'],
          subject: classes['subject'],
        ));
      });
      classes = retrievedClasses.toList();
      return classes;
    }
  }
}
