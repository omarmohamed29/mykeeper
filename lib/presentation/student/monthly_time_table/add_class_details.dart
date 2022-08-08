import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddClassDetails extends StatefulWidget {
  const AddClassDetails({Key? key}) : super(key: key);

  @override
  State<AddClassDetails> createState() => _AddClassDetailsState();
}

class _AddClassDetailsState extends State<AddClassDetails> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> classData = {
    'class_name': '',
    'location': '',
    'teacher_info': '',
    'extra_details': '',
  };

  Future<void> _uploadClassData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {} catch (error) {
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
          'Add class data',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Class name :",
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
                        return 'Class name cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (input) {
                      classData['class_name'] = input.toString();
                    },
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD18B81))),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "type the class name ! ",
                        hintStyle: TextStyle(
                            fontFamily: 'ubuntu',
                            color: Colors.grey,
                            fontSize: 15)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   const Text("Class Location :",
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
                        return 'Class Location cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (input) {
                      classData['location'] = input.toString();
                    },
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD18B81))),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "type the class location ! ",
                        hintStyle: TextStyle(
                            fontFamily: 'ubuntu',
                            color: Colors.grey,
                            fontSize: 15)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   const Text("Teacher information :",
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
                        return 'Teacher information cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (input) {
                      classData['teacher_info'] = input.toString();
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
                   const Text("Extra details :",
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
                    onSaved: (input) {
                      classData['extra_details'] = input.toString();
                    },
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD18B81))),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "Enter some extra details ! ",
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
                    onPressed: () {},
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
