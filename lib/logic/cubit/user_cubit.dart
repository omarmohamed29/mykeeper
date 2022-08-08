import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:mokhatat/data/model/user_model.dart';
import 'package:mokhatat/data/repository/user_repository.dart';
import 'package:mokhatat/data/webservice/user_webService.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  final UserWebservice userWebservice;
  UserCubit(
    this.userRepo,
    this.userWebservice,
  ) : super(UserInitial());

  Future<void> addUser(
      String name, String address, String email, String phoneNumber) async {
    await userWebservice
        .addUser(name, address, email, phoneNumber)
        .then((response) {
      if (response) {
        emit(UserAdded('your data has been added successfully'));
      } else {
        emit(UserError('Something went wrong please try again later'));
      }
    });
  }

  Future<void> retrieveDietData() async {
    await userRepo.retrieveData().then((data) {
      if (data.toString() == {}.toString()) {
        emit(UserError('Something went wrong please try again later'));
      } else {
        emit(UserRetrieved(data));
      }
    });
  }
}
