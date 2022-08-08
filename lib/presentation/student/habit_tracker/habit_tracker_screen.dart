import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/add_habit_cubit.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/habit_tracker_cubit.dart';
import 'package:mokhatat/presentation/widgets/habit_tracker/habit_tracker_widget.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({Key? key}) : super(key: key);

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  int date = DateTime.now().month;

  Future<void> getHabitsData() async {
    BlocProvider.of<AddHabitCubit>(context).retrieveHabits();
    BlocProvider.of<HabitTrackerCubit>(context).retrieveHabits();
  }

  @override
  void initState() {
    getHabitsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getHabitsData();
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFD18B81),
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 25,
              color: Color(0xFFD18B81),
            ),
            onPressed: () {
              Navigator.pushNamed(context, addHabitTracker);
            },
          )
        ],
        title: const Text(
          'Habit tracker',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 25),
        ),
      ),
      body:
          BlocBuilder<AddHabitCubit, AddHabitState>(builder: (context, state) {
        if (state is AllHabitsRetrieved) {
          return  Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: HabitsContainer(),
                ),
              ],
            ),
          );
        } else if (state is AddHabitInitial) {
          return const SizedBox();
        } else if (state is HabitsEdited) {
          return const SizedBox();
        } else {
          return CupertinoAlertDialog(
            title: const Text(
              'Note',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD18B81),
                  fontFamily: 'ubuntu',
                  fontSize: 20),
            ),
            content: const Text(
              'You don\'t have any habits to track this month try adding some !  ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD18B81),
                  fontFamily: 'ubuntu',
                  fontSize: 15),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  'Let\'s go !',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD18B81),
                      fontFamily: 'ubuntu',
                      fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, addHabitTracker);
                },
              )
            ],
          );
        }
      }),
    );
  }
}
