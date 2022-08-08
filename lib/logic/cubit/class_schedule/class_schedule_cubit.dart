import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:mokhatat/data/model/time_table/class_schedule_model.dart';
import 'package:mokhatat/data/repository/class_schedule_repository.dart';
import 'package:mokhatat/data/webservice/class_schedule_webservice.dart';

part 'class_schedule_state.dart';

class ClassScheduleCubit extends Cubit<ClassScheduleState> {
  final ClassScheduleWebService classScheduleWebService;
  final ClassScheduleRepo classScheduleRepo;
  ClassScheduleCubit(
    this.classScheduleWebService,
    this.classScheduleRepo,
  ) : super(ClassScheduleInitial());

  Future<void> retrieveClassScheduleData() async {
    await classScheduleRepo.retrieveclasses().then((data) {
      if (data.toString() == {}.toString()) {
        emit(ClassScheduleError('you havent set your ClassSchedules yet!'));
      } else {
        emit(ClassScheduleInitial());
        emit(ClassScheduleRetrieved(data as List<ClassScheduleModel>));
      }
    });
  }

  Future<void> addClassData(  String classTime, String day, String subject,) async{
    await classScheduleWebService.addScheduleData(classTime, day, subject).then((response){
      if(response){
        emit(ClassScheduleDataAdded('your Schedule data has been added successfully'));
      }else{
        emit(ClassScheduleError('Something went wrong please try again later'));
      }
    });
  }
}
