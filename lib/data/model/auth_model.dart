
class Auth {
 late final String token ;
 late final String userId;
 late final DateTime expiryDate; 
 String? errorMessage;

 Auth.fromJson(Map<String, dynamic> json){
  token = json['idToken'];
  userId = json['localId'];
  expiryDate = DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));
 }
 Auth.toMap(Map<String, dynamic> json){
  token = json['token'];
  userId = json['userId'];
  expiryDate = DateTime.parse(json['expiryDate']);
 }
 Auth({required this.token ,required this.userId ,required this.expiryDate , this.errorMessage});

}