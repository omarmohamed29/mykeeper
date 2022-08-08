import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/add_habit_cubit.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/habit_screen_cubit.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/habit_tracker_cubit.dart';

class HabitsContainer extends StatefulWidget {
  const HabitsContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<HabitsContainer> createState() => _HabitsContainerState();
}

class _HabitsContainerState extends State<HabitsContainer> {
  int statusIndex = 0;
  int statusIndexes = 0;
  String dropDownValue = '';
  String dropdownValue = '';
  bool isLoading = false;

  Widget habitsBuilder() {
    Size size = MediaQuery.of(context).size;
    final habitsFunc = BlocProvider.of<HabitScreenCubit>(context);
    final habits = BlocProvider.of<HabitScreenCubit>(context).getHabitsLocal();

    //Function  to change habit  color based  on points
    Color habitContainerColor(i, x) {
      for (int a = 0; a < habits.length; a++) {
        if (habitsFunc.habitLocal.habits[a].verticalPoint == i &&
            habitsFunc.habitLocal.habits[a].horizontalPoint == x) {
          return const Color(0xFFDF7861);
        }
      }
      return Colors.white;
    }

    //Function to remove a selected habit box
    removeItem(i, x) {
      for (int a = 0; a < habits.length; a++) {
        if (habitsFunc.habitLocal.habits[a].verticalPoint == i &&
            habitsFunc.habitLocal.habits[a].horizontalPoint == x) {
          habitsFunc.remove(a);
        }
      }
    }

    //habbits that builds the container based on the data come from web
    Widget habitsContainer(i, x) {
      return BlocBuilder<HabitTrackerCubit, HabitTrackerState>(
          builder: (context, state) {
        if (state is HabitTrackerRetrieved) {
          for (int w = 0; w < (state).habitTracker.length; w++) {
            for (int a = 0;
                a < (state).habitTracker[w].habitPoint.length;
                a++) {
              if ((state).habitTracker[w].habitPoint[a].verticalPoint == i &&
                  (state).habitTracker[w].habitPoint[a].horizontalPoint == x) {
                return Container(
                    height: size.width / 11 - 15,
                    margin: const EdgeInsets.all(5),
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(6.0))));
              }
            }
          }
        }
        return Container(
            height: size.width / 11 - 15,
            margin: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  setState(() {
                    statusIndex = x;
                    statusIndexes = i;
                    habitsFunc.addTolist(statusIndexes, statusIndex, false);
                  });
                });
              },
              onDoubleTap: () {
                setState(() {
                  removeItem(i, x);
                });
              },
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFDF7861), width: 1),
                      color: habitContainerColor(i, x),
                      borderRadius: BorderRadius.circular(6.0))),
            ));
      });
    }

    return BlocBuilder<AddHabitCubit, AddHabitState>(builder: (context, state) {
      if (state is AllHabitsRetrieved) {
        final monthlyHabit = (state)
            .habits
            .where((habit) => habit.month == DateTime.now().month)
            .toList();
        return Column(
          children: [
            for (int i = 1; i < 31; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Text(
                    i.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDF7861),
                        fontFamily: 'ubuntu',
                        fontSize: 10),
                  )),
                  for (int x = 0; x < monthlyHabit[0].habits.length; x++)
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                           i != 1
                              ? const SizedBox()
                              : Container(
                                height: 100,
                                child: RotatedBox(
                                    quarterTurns:3,
                                    child: Text(
                                    monthlyHabit[0].habits[x],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFDF7861),
                                        fontFamily: 'ubuntu',
                                        fontSize: 10),
                                  ),),
                              ),
                          habitsContainer(i, x),
                        ],
                      ),
                    )
                ],
              )
          ],
        );
      } else {
        return Column(
          children: [
            for (int i = 1; i < 32; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Text(
                    i.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDF7861),
                        fontFamily: 'ubuntu',
                        fontSize: 10),
                  )),
                  for (int x = 0; x < 10; x++)
                    Expanded(
                      flex: 2,
                      child: habitsContainer(i, x),
                    )
                ],
              )
          ],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: isLoading
              ? const SpinKitCircle(
                  color: Color(0xFFDF7861),
                  size: 30,
                )
              : IconButton(
                  onPressed: () async {
                    final habitsFunc =
                        BlocProvider.of<HabitScreenCubit>(context);
                    if (habitsFunc.habitLocal.habits.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      await BlocProvider.of<HabitTrackerCubit>(context)
                          .uploadHabitState(habitsFunc.habitLocal.habits,
                              DateTime.now().month.toString());
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      null;
                    }
                  },
                  icon: const Icon(
                    Icons.done,
                    size: 30,
                    color: Color(0xFFDF7861),
                  )),
        ),
        Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 10,
              child: habitsBuilder(),
            ),
          ),
        ),
      ],
    );
  }
}
