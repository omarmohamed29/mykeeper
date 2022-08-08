import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/logic/cubit/class_schedule/class_schedule_cubit.dart';

class AddClassSchedule extends StatefulWidget {
  const AddClassSchedule({Key? key}) : super(key: key);

  @override
  State<AddClassSchedule> createState() => _AddClassScheduleState();
}

class _AddClassScheduleState extends State<AddClassSchedule> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();
  String dropdownValue = '';
  String classData = '';
  List<String> weekDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'ThursDay',
    'Friday',
    'Saturday',
  ];
  Future<void> _uploadSchedule() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<ClassScheduleCubit>(context).addClassData(
            "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name.toUpperCase()}",
            dropdownValue,
            classData);
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget dropDownList(String initvalue, List<String> categories) {
    setState(() {
      dropdownValue = initvalue;
    });
    return SizedBox(
      height: 130,
      child: Column(
        children: [
          SizedBox(
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select a day : ',
                    style: TextStyle(
                        fontFamily: 'ubuntu',
                        color: Color(0xFFD18B81),
                        fontSize: 15),
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
                        items: categories.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
        title: const Text(
          'Add schedule data',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          dropDownList(weekDays[0], weekDays),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pick class time :",
                    style: TextStyle(
                        color: Color(0xFFD18B81),
                        fontFamily: 'ubuntu',
                        fontSize: 15)),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: const Color(0xFFD18B81)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}",
                            style: const TextStyle(
                                fontFamily: 'ubuntu',
                                color: Color(0xFFD18B81),
                                fontSize: 18),
                          ),
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                builder: (context, child) {
                                  return Theme(
                                    child: child!,
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xFFD18B81),
                                        onPrimary: Colors.white,
                                        onSurface: Colors.grey,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: const Color(
                                              0xFFD18B81), // button text color
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                context: context,
                                initialTime: selectedTime,
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                              if (timeOfDay != null &&
                                  timeOfDay != selectedTime) {
                                setState(() {
                                  selectedTime = timeOfDay;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.timelapse_rounded,
                              size: 30,
                              color: Color(0xFFDF7861),
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Class :",
                      style: TextStyle(
                          color: Color(0xFFD18B81),
                          fontFamily: 'ubuntu',
                          fontSize: 15)),
                  TextFormField(
                    cursorColor: const Color(0xFFD18B81),
                    style: const TextStyle(
                      fontFamily: 'ubuntu',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Class cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (input) {
                      classData = input.toString();
                    },
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD18B81))),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "type a goal to achieve ! ",
                        hintStyle: TextStyle(
                            fontFamily: 'ubuntu',
                            color: Colors.grey,
                            fontSize: 15)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: MaterialButton(
                    onPressed: () {
                      _uploadSchedule();
                    },
                    color: const Color(0xFFD18B81),
                    height: 50,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    hoverColor: const Color(0xFFD18B81),
                    child: Center(
                      child: _isLoading
                          ? const Center(
                              child: SpinKitCircle(
                              color: Colors.white,
                              size: 22,
                            ))
                          : const Center(
                              child: Text(
                                "Submit your data ! ",
                                style: TextStyle(
                                    fontFamily: 'ubuntu',
                                    color: Colors.white,
                                    fontSize: 23),
                              ),
                            ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
