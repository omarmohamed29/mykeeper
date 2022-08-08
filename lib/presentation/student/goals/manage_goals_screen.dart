import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/logic/cubit/goal/goal_cubit.dart';

class ManageGoalsScreen extends StatefulWidget {
  const ManageGoalsScreen({Key? key}) : super(key: key);

  @override
  State<ManageGoalsScreen> createState() => _ManageGoalsScreenState();
}

class _ManageGoalsScreenState extends State<ManageGoalsScreen> {
  bool _isLoading = false;
  String goal = '';
  String dropdownValue = '';
  List<String> goalCategories = [
    'Study/Career',
    'Community',
    'Family',
    'Health',
    'Life style',
    'Financial',
    'Interests'
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                    'Choose a category : ',
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

  Future<void> _uploadGoal() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<GoalCubit>(context)
            .addBookshelfData(goal, false, dropdownValue);
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoalCubit, GoalState>(
      listener: (context, state) {
        if (state is GoalDataAdded) {
          Navigator.pop(context);
        }
      },
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
          title: const Text(
            'Add Goals',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFD18B81),
                fontFamily: 'ubuntu',
                fontSize: 30),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            dropDownList(goalCategories[0], goalCategories),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Goal",
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
                          return 'goal  cannot be empty';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        goal = input.toString();
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
                        _uploadGoal();
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
            )
          ],
        ),
      ),
    );
  }
}
