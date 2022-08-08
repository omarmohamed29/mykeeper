import 'package:flutter/material.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/presentation/widgets/monthly_time_table/class_schedule_widget.dart';

class MonthlyTimeTable extends StatefulWidget {
  const MonthlyTimeTable({Key? key}) : super(key: key);

  @override
  State<MonthlyTimeTable> createState() => _MonthlyTimeTableState();
}

class _MonthlyTimeTableState extends State<MonthlyTimeTable> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
              'Monthly time table',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD18B81),
                  fontFamily: 'ubuntu',
                  fontSize: 20),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, addMonthlyTimeTable);
                                  },
                                  leading: const Icon(
                                    Icons.class__outlined,
                                    size: 25,
                                    color: Color(0xFFD18B81),
                                  ),
                                  title: const Text(
                                    'Add schedule data',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFD18B81),
                                        fontFamily: 'ubuntu',
                                        fontSize: 18),
                                  ),
                                  trailing:  const Icon(
                                    Icons.arrow_right_rounded,
                                    size: 50,
                                    color: Color(0xFFD18B81),
                                  ),
                                ),
                                 ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, addClassDetails);
                                  },
                                  leading: const Icon(
                                    Icons.edit,
                                    size: 25,
                                    color: Color(0xFFD18B81),
                                  ),
                                  title: const Text(
                                    'Add class details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFD18B81),
                                        fontFamily: 'ubuntu',
                                        fontSize: 18),
                                  ),
                                  trailing:  const Icon(
                                    Icons.arrow_right_rounded,
                                    size: 50,
                                    color: Color(0xFFD18B81),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                    color: Color(0xFFDF7861),
                  ))
            ],
            bottom: const TabBar(
              indicatorColor: Color(0xFFD18B81),
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Class schedule',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD18B81),
                        fontFamily: 'ubuntu',
                        fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    'Class details',
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
          body: TabBarView(
            children: [
              const ClassSchedule(),
              Container(),
            ],
          )),
    );
  }
}
