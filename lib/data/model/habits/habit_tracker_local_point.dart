import 'package:mokhatat/data/model/habits/habit_point_model.dart';

class HabitLocal{
  // ignore: prefer_final_fields
  List<HabitPointModel> _habits = [];
  List<HabitPointModel> get habits{
    return[..._habits];
  }

   void addToList(int vertical, int horizontal , bool status) {

    _habits.add(HabitPointModel(verticalPoint: vertical, horizontalPoint: horizontal , status: status));
  }

  void emptyList(){
  _habits.clear();
  }
  
  void removeItem(index){
    _habits.removeAt(index);
  }

}