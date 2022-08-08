import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import '../../data/model/auth_model.dart';
import '../../data/repository/auth_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  final Sharedprefs sharedprefs;
  Timer? _authTimer;
  late DateTime timeToExpiry;

  Auth auth = Auth(token: '', userId: '', expiryDate: DateTime.now());
  AuthCubit(this.authRepo, this.sharedprefs) : super(AuthInitial());

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    await authRepo.authenticate(email, password, urlSegment).then((auth) {
      if (auth.toString().contains('EMAIL_EXISTS')) {
        emit(AuthError(error: 'This email address is already in use. '));
      } else if (auth.toString().contains('INVALID_EMAIL')) {
        emit(AuthError(error: 'This is not a valid email address. '));
      } else if (auth.toString().contains('WEAK_PASSWORD')) {
        emit(AuthError(error: 'This password is too weak.  '));
      } else if (auth.toString().contains('EMAIL_NOT_FOUND')) {
        emit(AuthError(error: 'Could not find a user with that email. '));
      } else if (auth.toString().contains('INVALID_PASSWORD')) {
        emit(AuthError(error: 'INVALID PASSWORD '));
      } else {
        emit(AuthSucceed(authData: auth));
        final authData = auth as Auth;
        final shared = sharedprefs.toMap(authData.token, authData.userId,
            authData.expiryDate.toIso8601String());
        timeToExpiry = authData.expiryDate;
        sharedprefs.saveData(shared);
        autoLogout();
      }
    });
  }

  Future<void> tryAutoLogin() async {
    final prefs = await sharedprefs.retrieveData();
    if (!prefs.containsKey('token')) {
      emit(AuthInitial());
    } else {
      final authData = Auth.toMap(prefs);
      timeToExpiry = authData.expiryDate;
      emit(AuthSucceed(authData: authData));
      autoLogout();
    }
  }

  Future<void> logout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    sharedprefs.deleteData();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final expiryTime = timeToExpiry.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiryTime), logout);
  }
}
