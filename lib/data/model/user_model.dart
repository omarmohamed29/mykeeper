class User {
  late final String name ;
  late final String phone;
  late final String address;

  User.fromJson(Map<String , dynamic> json){
      name  = json['name'];
      phone = json['phoneNumber'];
      address = json['address'];
  }

  User({required this.name , required this.phone , required this.address});
}