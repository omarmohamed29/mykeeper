import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokhatat/logic/cubit/auth_cubit.dart';
import 'package:mokhatat/presentation/widgets/drawerIcons.dart';
import '../../constants/strings.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<String> titles = [
    'Home',
    'schedule',
    'Book shelf',
    'Dates to remember',
    'Habit tracker',
    'Goals',
    'Time Table',
    'Logout',
  ];
  List<bool> isHighLighted = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool isRouteSame = false;
  List<Icon> icon = [
    const Icon(
      MydrawerIcons.home,
      color: Color(0xFFD18B81),
    ),
    const Icon(
      MydrawerIcons.schedule,
    ),
    const Icon(
      MydrawerIcons.bookshelf,
    ),
    const Icon(
      MydrawerIcons.datestoremember,
    ),
    const Icon(
      MydrawerIcons.habittracker,
    ),
    const Icon(
      MydrawerIcons.goals,
    ),
    const Icon(
      MydrawerIcons.timetable,
    ),
    const Icon(
      MydrawerIcons.book,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    List drawerFunctions = [
      () {
        Navigator.popUntil(context, (route) {
          if (route.settings.name == homePage) {
            isRouteSame = true;
          }
          return true;
        });
        if (!isRouteSame) {
          Navigator.pop(context);
        }
      },
      () {
        Navigator.pushNamed(context, homeSchedule);
      },
      () {
        Navigator.pushNamed(context, bookShelf);
      },
      () {
        Navigator.pushNamed(context, datesToRemember);
      },
      () {
        Navigator.pushNamed(context, habitTracker);
      },
      () {
        Navigator.pushNamed(context, goals);
      },
      () {
        Navigator.pushNamed(context, monthlyTimeTable);
      },
      () {
        Navigator.popUntil(context, (route) => route.isFirst);
        BlocProvider.of<AuthCubit>(context).logout();
      }
    ];

    return SafeArea(
      child: Drawer(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 4),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(
                    angle: 40,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.add, size: 30, color: Colors.grey),
                    ),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 83,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        for (int i = 0; i < isHighLighted.length; i++) {
                          if (index == i) {
                            setState(() {
                              isHighLighted[index] = true;
                            });
                          } else {
                            isHighLighted[index] = false;
                          }
                        }
                      },
                      child: ListTile(
                        leading: icon[index],
                        title: Text(
                          titles[index],
                          style: TextStyle(
                              fontSize: 18,
                              color: isHighLighted[index]
                                  ? const Color(0xFFD18B81)
                                  : Colors.grey),
                        ),
                        onTap: drawerFunctions[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
