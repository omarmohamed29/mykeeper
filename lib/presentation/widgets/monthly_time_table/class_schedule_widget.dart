import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/class_schedule/class_schedule_cubit.dart';

class ClassSchedule extends StatefulWidget {
  const ClassSchedule({Key? key}) : super(key: key);

  @override
  State<ClassSchedule> createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  List<String> weekDays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  String choosedDate = '';
  int ind = 0;
  Future<void> getClassData() async {
    await BlocProvider.of<ClassScheduleCubit>(context)
        .retrieveClassScheduleData();
  }
  @override
  void initState() {
    setState(() {
      choosedDate = weekDays[0];
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getClassData();
    super.didChangeDependencies();
  }

  Future<void> refresh() async {
    getClassData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      color: const Color(0xFFD18B81),
      child: BlocBuilder<ClassScheduleCubit, ClassScheduleState>(
          builder: ((context, state) {
        if (state is ClassScheduleRetrieved) {
          final days = (state)
              .classes
              .where((classes) => classes.day.contains(choosedDate))
              .toList();
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(
                  width: 400,
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: weekDays.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                choosedDate = weekDays[index];
                                ind = index;
                                inspect(choosedDate);
                              });
                            },
                            child: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                  color: ind == index
                                      ? Color(0xFFD18B81)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    weekDays[index],
                                    style: TextStyle(
                                        color: ind == index
                                            ? Colors.white
                                            : Color(0xFFD18B81),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ubuntu',
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            child: Row(
                              children: [
                                Text(
                                  TimeOfDay.fromDateTime(DateFormat.jm()
                                          .parse(days[index].classTime))
                                      .format(context)
                                      .toString(),
                                  style: const TextStyle(
                                      color: Color(0xFFD18B81),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ubuntu',
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD18B81),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      days[index].subject,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ubuntu',
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        } else if (state is ClassScheduleInitial) {
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
              'You did\'t add a class schedule add now ! ',
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
                  Navigator.pushNamed(context, addMonthlyTimeTable);
                },
              )
            ],
          );
        }
      })),
    );
  }
}
