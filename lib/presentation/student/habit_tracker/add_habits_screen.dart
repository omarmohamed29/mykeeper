import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/add_habit_cubit.dart';
import 'package:mokhatat/presentation/widgets/drawerIcons.dart';

class AddHabitsScreen extends StatefulWidget {
  const AddHabitsScreen({Key? key}) : super(key: key);

  @override
  State<AddHabitsScreen> createState() => _AddHabitsScreenState();
}

class _AddHabitsScreenState extends State<AddHabitsScreen> {
  List<Widget> habitsListWidget = [];
  List<String> habits = [];
  String text = '';
  bool _isLoading = false;
  FocusNode focusNode = FocusNode();

  void _addHabitWidget() {
    if (habitsListWidget.length < 10) {
      setState(() {
        habitsListWidget.add(_myTextField());
      });
    } else {
      null;
    }
  }

  void _addHabitsList(value) {
    if (habitsListWidget.length < 11 && value != null) {
      setState(() {
        habits.add(value);
        inspect(habits);
      });
    }
  }

  Future<void> uploadHabit() async {
    if (habits.isNotEmpty) {
      try {
        _isLoading = true;
        await BlocProvider.of<AddHabitCubit>(context)
            .addHabits(habits, DateTime.now().month);
      } catch (error) {
        rethrow;
      }
      _isLoading = false;
    } else {
      return;
    }
  }

  Widget createsTextField() {
    return habitsListWidget.isNotEmpty
        ? Column(
            children: [
              SizedBox(
                height: 90.0 * habitsListWidget.length,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: habitsListWidget.length,
                    itemBuilder: (context, i) {
                      return habitsListWidget[i];
                    }),
              ),
              habitsListWidget.length < 10
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: MaterialButton(
                        onPressed: _addHabitWidget,
                        color: const Color(0xFFD18B81),
                        height: 50,
                        minWidth: 100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 1,
                        hoverColor: const Color(0xFFD18B81),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "Add another habit",
                                style: TextStyle(
                                    fontFamily: 'ubuntu',
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(top: 30),
            child: MaterialButton(
              onPressed: _addHabitWidget,
              color: const Color(0xFFD18B81),
              height: 50,
              minWidth: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 1,
              hoverColor: const Color(0xFFD18B81),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      "Add another important event",
                      style: TextStyle(
                          fontFamily: 'ubuntu',
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _myTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        )),
        width: MediaQuery.of(context).size.width,
        child: Focus(
          onFocusChange: (hasFocus) {
            hasFocus == true ? null : _addHabitsList(text);
          },
          child: TextField(
            textInputAction: TextInputAction.done,
            enableInteractiveSelection: true,
            cursorColor: const Color(0xFFD18B81),
            keyboardType: TextInputType.text,
            onChanged: (input) {
              setState(() {
                text = input;
                print(text);
              });
            },
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD18B81))),
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: "Enter a habit please ! ",
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 20.0, fontFamily: 'ubuntu')),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Add Habits',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 25),
        ),
      ),
      body: BlocListener<AddHabitCubit, AddHabitState>(
        listener: (context, state) {
          if (state is HabitsUploaded) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child: Stack(
              children: [
                //The Create button
                ListView(
                  scrollDirection: Axis.vertical,

                  children: [
                    const Text(
                      'by pressing this button you can add up to 10 habits  to track',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD18B81),
                          fontFamily: 'ubuntu',
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    createsTextField(),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: MaterialButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                setState(() {
                                  uploadHabit();
                                });
                              },
                        color: const Color(0xFFD18B81),
                        height: 60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 1,
                        hoverColor: const Color(0xFFD18B81),
                        child: _isLoading
                            ? const SpinKitCircle(
                                color: Colors.white,
                                size: 20,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    MydrawerIcons.habittracker,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "add the habits",
                                    style: TextStyle(
                                        fontFamily: 'ubuntu',
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
