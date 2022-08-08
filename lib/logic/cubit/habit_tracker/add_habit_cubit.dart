import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mokhatat/data/model/habits/habit_model.dart';
import 'package:mokhatat/data/repository/habits_repository.dart';
import 'package:mokhatat/data/webservice/habit_webService.dart';

part 'add_habit_state.dart';

class AddHabitCubit extends Cubit<AddHabitState> {
  final HabitsRepo habitsRepo;
  AddHabitCubit(
    this.habitsRepo,
  ) : super(AddHabitInitial());

  Future<void> addHabits(List<String> habits  , int month) async{
    await habitsRepo.addHabits(habits, month).then((response){
      if(response){
        emit(HabitsError('Something went wrong try again later'));
      }else{
        emit(HabitsUploaded('Habit uploaded successfully'));
      }
    });
  } 

  Future<void> retrieveHabits()async{
      await habitsRepo.retrieveHabits().then((habits){
        if(habits.toString() == {}.toString()){
          emit(HabitsError('You dont have any habits  yet , try to add  some'));
        }else{
          emit(AddHabitInitial());
          emit(AllHabitsRetrieved(habits));
        }
      });
    }

}
