
class Diet {
  late String startWeight; 
  late String targetWeight;
  late String month ; 

  Diet({
    required this.startWeight,
    required this.targetWeight,
    required this.month
  });

   Diet.fromJson(Map<String , dynamic> json){
      startWeight = json['startWeight'];
      targetWeight = json['targetWeight'];
      month = json['month'];
  }
}
