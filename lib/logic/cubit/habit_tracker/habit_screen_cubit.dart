import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mokhatat/data/model/habits/habit_point_model.dart';

import 'package:mokhatat/data/model/habits/habit_tracker_local_point.dart';

part 'habit_screen_state.dart';

class HabitScreenCubit extends Cubit<HabitScreenState> {
  HabitLocal habitLocal ;
  HabitScreenCubit(
    this.habitLocal,
  ) : super(HabitScreenInitial());

  void addTolist(int vertical, int horizontal ,bool status){
    habitLocal.addToList(vertical, horizontal, status);
  }
   void remove(index){
    habitLocal.removeItem(index);
  }
   void clear(int vertical, int horizontal ,bool status){
    habitLocal.emptyList();
  }
  List<HabitPointModel> getHabitsLocal(){
    return habitLocal.habits;
 }

}

