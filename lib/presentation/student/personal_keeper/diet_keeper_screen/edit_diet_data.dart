import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/constants/strings.dart';

import 'package:mokhatat/logic/cubit/personal_traker/diet_cubit.dart';

class EditDietData extends StatefulWidget {
  EditDietData({
    Key? key,
  }) : super(key: key);

  @override
  State<EditDietData> createState() => _EditDietDataState();
}

class _EditDietDataState extends State<EditDietData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _weights = {
    'start_weight': '',
    'target_weight': '',
    'month': DateTime.now().month.toString()
  };
  bool _isLoading = false;

  Future<void> getDietData() async {
    await BlocProvider.of<DietCubit>(context).retrieveDietData();
  }

  @override
  void initState() {
    getDietData();
    super.initState();
  }

  Future<void> _uploadWeights() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<DietCubit>(context).editDietData(
            _weights['start_weight'].toString(),
            _weights['target_weight'].toString(),
            _weights['month'].toString());
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
    return BlocConsumer<DietCubit, DietState>(
      listenWhen: (context,state){
        return state is DietDataEdit;
      },
      listener: (context, state) {
        if (state is DietDataEdit) {
         Navigator.pushReplacementNamed(context, dietScreen);
        }
      },
      builder: (context, state) {
        if (state is DietRetrieved) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Color(0xFFDF7861),
                      )),
                ),
                const Center(
                  child: Text(
                    'Edit your Diet Data',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDF7861),
                        fontFamily: 'buffalo',
                        fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Start weight",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD18B81),
                                fontFamily: 'buffalo',
                                fontSize: 25)),
                        TextFormField(
                          initialValue: (state).diet.startWeight,
                          cursorColor: const Color(0xFFD18B81),
                          style: const TextStyle(
                            fontFamily: 'ubuntu',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Invalid wight ';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _weights['start_weight'] = input.toString();
                          },
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD18B81))),
                              border:
                                  OutlineInputBorder(borderSide: BorderSide()),
                              hintText: "Enter your current weight",
                              hintStyle: TextStyle(
                                  fontFamily: 'buffalo',
                                  color: Colors.grey,
                                  fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Target weight
                        const Text("Target weight",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD18B81),
                                fontFamily: 'buffalo',
                                fontSize: 25)),
                        TextFormField(
                          initialValue: (state).diet.targetWeight,
                          cursorColor: const Color(0xFFD18B81),
                          style: const TextStyle(
                            fontFamily: 'ubuntu',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Invalid wight ';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _weights['target_weight'] = input.toString();
                          },
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD18B81))),
                              border:
                                  OutlineInputBorder(borderSide: BorderSide()),
                              hintText: "Enter your target weight",
                              hintStyle: TextStyle(
                                  fontFamily: 'buffalo',
                                  color: Colors.grey,
                                  fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: MaterialButton(
                          onPressed: _uploadWeights,
                          color: const Color(0xFFD18B81),
                          height: 50,
                          minWidth: 200,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
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
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
