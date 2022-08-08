class Goal {
  late String id;
  late String goal;
  late bool status;
  late String category;
  Goal({
    required this.id,
    required this.goal,
    required this.status,
    required this.category,
  });

  Goal.fromMap(Map<String , dynamic> json){
    goal = json['goal'];
    status = json['status'];
  }
}
