import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/dates_to_remember/dates_to_remember_cubit.dart';

class DatesToRemember extends StatefulWidget {
  const DatesToRemember({Key? key}) : super(key: key);

  @override
  State<DatesToRemember> createState() => _DatesToRememberState();
}

class _DatesToRememberState extends State<DatesToRemember> {
  String dropdownValue = '';
  List<String> addeddates = [];
  Future<void> getAllDates() async {
    await BlocProvider.of<DatesToRememberCubit>(context)
        .datesToRemememberList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllDates();
  }

  Widget dropDownList(String initvalue, List<String> dates) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          SizedBox(
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose a date to preview : ',
                    style: TextStyle(
                        fontFamily: 'ubuntu',
                        color:  Color(0xFFD18B81),
                        fontSize: 18),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                        colorScheme: const ColorScheme.light(
                            primary: Color(0xFFD18B81))),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFD18B81))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Color(0xFFD18B81)))),
                        value: initvalue,
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_rounded,
                          color: Color(0xFFD18B81),
                        ),
                        elevation: 16,
                        style: const TextStyle(color: Color(0xFFD18B81)),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: dates.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(DateFormat('d MMMM yyy')
                                .format(DateTime.parse(value))
                                .toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 25,
              color: Color(0xFFD18B81),
            ),
            onPressed: () {
              Navigator.pushNamed(context, addDatesToRemember);
            },
          )
        ],
        title: const Text(
          'Dates to remember',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 25),
        ),
      ),
      body: BlocBuilder<DatesToRememberCubit, DatesToRememberState>(
          builder: (context, state) {
        if (state is DatesRetrieved) {
          final List<String> datesOnly = [];
          final dates = dropdownValue == ''
              ? (state).datesToRemember
              : (state)
                  .datesToRemember
                  .where((date) => date.date == DateTime.parse(dropdownValue))
                  .toList();
          for (var date in (state).datesToRemember) {
            datesOnly.add(date.date.toString());
          }
          addeddates = datesOnly;

          inspect(dates);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: dropDownList(addeddates[0], addeddates),
              ),
              Text(
                'Upcoming events on : ' +
                    DateFormat('MMMM yyy').format(dates[0].date),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontFamily: 'ubuntu',
                    fontSize: 18),
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: dates[0].events.length,
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
                          dates[0].events[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD18B81),
                              fontFamily: 'ubuntu',
                              fontSize: 15),
                        ),
                        subtitle: Text(
                          DateFormat('MMMM yyy').format(dates[0].date),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontFamily: 'ubuntu',
                              fontSize: 12),
                        ),
                      ),
                    );
                  }),
            ],
          );
        } else if (state is DatesToRememberInitial) {
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
              'You don\'t have any important dates till now , try adding some ! ',
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
                  Navigator.pushNamed(context, addDatesToRemember);
                },
              )
            ],
          );
        }
      }),
    );
  }
}
