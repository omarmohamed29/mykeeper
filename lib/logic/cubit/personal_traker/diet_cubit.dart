import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mokhatat/data/model/personal_keeper/diet.dart';
import 'package:mokhatat/data/repository/dietRepository.dart';
import 'package:mokhatat/data/webservice/dietWebService.dart';

part 'diet_state.dart';

class DietCubit extends Cubit<DietState> {
  final DietWebService dietWebService;
  final DietRepo dietRepo;
  DietCubit(
    this.dietWebService,
    this.dietRepo,
  ) : super(DietInitial());

  Future<void> retrieveDietData() async {
    await dietRepo.retrieveData().then((data) {
      if (data.toString() == {}.toString()) {
        emit(DietError('you havent set your weight yet!'));
      } else if (data.toString() != {}.toString() && int.parse((data).month) != DateTime.now().month) {
        emit(DietError('you havent set your weight for the new month yet!'));
      } else {
        emit(DietInitial());
        emit(DietRetrieved(data));
      }
    });
  }

  Future<void> addDietData(
      String startWeight, String targetWeight, String month) async {
    await dietWebService
        .addDietData(startWeight, targetWeight, month)
        .then((response) {
      if (response) {
        emit(DietDataAdded('your diet data has been added successfully'));
      } else {
        emit(DietError('Something went wrong please try again later'));
      }
    });
  }

  Future<void> editDietData(
      String startWeight, String targetWeight, String month) async {
    await dietWebService
        .editDietData(startWeight, targetWeight, month)
        .then((response) {
      if (response) {
        emit(DietDataEdit('your diet data has been edited successfully'));
      } else {
        emit(DietError('Something went wrong please try again later'));
      }
    });
  }
}
