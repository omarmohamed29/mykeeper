
import 'package:mokhatat/data/model/user_model.dart';
import 'package:mokhatat/data/webservice/user_webService.dart';

class UserRepo {
  final UserWebservice userWebservice;

  UserRepo(this.userWebservice);

  Future<dynamic> retrieveData() async {
    final retrievedData = await userWebservice.retrieveUser();
    if (retrievedData.isEmpty) {
      return {};
    } else {
     return User.fromJson(retrievedData);
    }
  }
}