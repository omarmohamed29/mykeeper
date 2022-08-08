
class DatesToRememberModel {
  late final DateTime date ;
  late final List<dynamic> events;

  DatesToRememberModel({
    required this.date,
    required this.events,
  });
  
  DatesToRememberModel.fromMap(Map<String , dynamic> json){
    date = json['date'];
    events = json['events'] as List<String>;
  }

}
