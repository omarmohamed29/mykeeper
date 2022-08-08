import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/goal/goal_cubit.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  Future<bool> getGoalskData() async {
    await BlocProvider.of<GoalCubit>(context).retrieveGoalfData();
    return true;
  }

  Future<void> setGoalDone(
      String goal, bool status, String category, String id) async {
    await BlocProvider.of<GoalCubit>(context)
        .editBookshelfData(goal, status, category, id);
  }

  List<bool> goalstatus = [];

  @override
  void didChangeDependencies() {
    getGoalskData();
    super.didChangeDependencies();
  }

  Future<void> refresh() async {
    getGoalskData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      color: const Color(0xFFD18B81),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
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
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, manageGoals);
                },
                child: const Text(
                  'Manage goals',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD18B81),
                      fontFamily: 'ubuntu',
                      fontSize: 15),
                ),
              ),
            ],
            title: const Text(
              'My Goals',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD18B81),
                  fontFamily: 'ubuntu',
                  fontSize: 30),
            ),
            bottom: const TabBar(
              indicatorColor:  Color(0xFFD18B81),
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Current',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD18B81),
                        fontFamily: 'ubuntu',
                        fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Done',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD18B81),
                        fontFamily: 'ubuntu',
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            BlocConsumer<GoalCubit, GoalState>(
              listener: (context, state) {
                if (state is GoalDataEdit) {
                  getGoalskData();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text((state).response),
                    backgroundColor: const Color(0xFFD18B81),
                    elevation: 0.0,
                    action: SnackBarAction(
                      label: 'Okay!',
                      textColor: Colors.white,
                      onPressed: () {
                        getGoalskData();
                      },
                    ),
                  ));
                }
              },
              builder: (context, state) {
                if (state is GoalRetrieved) {
                  final currentGoals = (state).goal.where((goal) => goal.status == false).toList();
                  return ListView.builder(
                      itemCount: currentGoals.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            selected: true,
                            selectedTileColor:
                                const Color(0xFFD18B81).withOpacity(0.3),
                            title: Text(
                              currentGoals[index].goal,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD18B81),
                                  fontFamily: 'ubuntu',
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                              currentGoals[index].category,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontFamily: 'ubuntu',
                                  fontSize: 12),
                            ),
                            trailing: Checkbox(
                              value: currentGoals[index].status,
                              activeColor: const Color(0xFFD18B81),
                              checkColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                              onChanged: (bool? value) {
                                setState(() {
                                  setGoalDone(
                                      currentGoals[index].goal,
                                      value!,
                                      currentGoals[index].category,
                                      currentGoals[index].id);
                                });
                              },
                            ),
                          ),
                        );
                      });
                } else if (state is GoalInitial) {
                  return const SizedBox();
                } else if (state is GoalDataEdit) {
                  return const Center(
                      child: SpinKitCircle(
                    color: Color(0xFFD18B81),
                    size: 22,
                  ));
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
                      'You don\'t have goals yet try to add some',
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
                          Navigator.pushNamed(context, manageGoals);
                        },
                      )
                    ],
                  );
                }
              },
            ),
             BlocConsumer<GoalCubit, GoalState>(
              listener: (context, state) {
                if (state is GoalDataEdit) {
                  getGoalskData();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text((state).response),
                    backgroundColor: const Color(0xFFD18B81),
                    elevation: 0.0,
                    action: SnackBarAction(
                      label: 'Okay!',
                      textColor: Colors.white,
                      onPressed: () {
                        getGoalskData();
                      },
                    ),
                  ));
                }
              },
              builder: (context, state) {
                if (state is GoalRetrieved) {
                  final currentGoals = (state).goal.where((goal) => goal.status == true).toList();
                  return ListView.builder(
                      itemCount: currentGoals.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            selected: true,
                            selectedTileColor:
                                const Color(0xFFD18B81).withOpacity(0.3),
                            title: Text(
                              currentGoals[index].goal,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD18B81),
                                  fontFamily: 'ubuntu',
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                              currentGoals[index].category,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontFamily: 'ubuntu',
                                  fontSize: 12),
                            ),
                            trailing: Checkbox(
                              value: currentGoals[index].status,
                              activeColor: const Color(0xFFD18B81),
                              checkColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                              onChanged: (bool? value) {
                                setState(() {
                                  setGoalDone(
                                      currentGoals[index].goal,
                                      value!,
                                      currentGoals[index].category,
                                      currentGoals[index].id);
                                });
                              },
                            ),
                          ),
                        );
                      });
                } else if (state is GoalInitial) {
                  return const SizedBox();
                } else if (state is GoalDataEdit) {
                  return const Center(
                      child: SpinKitCircle(
                    color: Color(0xFFD18B81),
                    size: 22,
                  ));
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
                      'You don\'t have goals yet try to add some',
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
                          Navigator.pushNamed(context, manageGoals);
                        },
                      )
                    ],
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
