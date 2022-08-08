import 'dart:async';

import'../webservice/auth_webservice.dart';

import '../model/auth_model.dart';

class AuthRepo {
  final AuthWebservice authentication;
  AuthRepo(this.authentication);

  Future<dynamic> authenticate(String email, String password , String urlSegment) async {
    final authData = await authentication.authenticate(email, password ,urlSegment);
    if(authData.toString().contains('error')){
    return authData['error']['message'];
    }else{
    final data = Auth.fromJson(authData);
    return data;
    }
  }

  




}
