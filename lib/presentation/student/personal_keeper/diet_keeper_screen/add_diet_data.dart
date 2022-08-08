import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/logic/cubit/personal_traker/diet_cubit.dart';

class AddDietData extends StatefulWidget {
  const AddDietData({Key? key}) : super(key: key);

  @override
  State<AddDietData> createState() => _AddDietDataState();
}

class _AddDietDataState extends State<AddDietData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _weights = {
    'start_weight': '',
    'target_weight': '',
    'month': DateTime.now().month.toString()
  };
  bool _isLoading = false;

  Future<void> _uploadWeights() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<DietCubit>(context).addDietData(
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
    return BlocListener<DietCubit, DietState>(
      listener: (context, state) {
        if (state is DietDataAdded) {
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
            'Add diet data',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFD18B81),
                fontFamily: 'ubuntu',
                fontSize: 30),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Start weight : ",
                        style: TextStyle(
                            color: Color(0xFFD18B81),
                            fontFamily: 'ubuntu',
                            fontSize: 18)),
                    TextFormField(
                      cursorColor: const Color(0xFFD18B81),
                      style: const TextStyle(
                        fontFamily: 'ubuntu',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || int.parse(value) >= 200) {
                          return 'Invalid wight ';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _weights['start_weight'] = input.toString();
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD18B81))),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: "Enter your current weight",
                          hintStyle: TextStyle(
                              fontFamily: 'ubuntu',
                              color: Colors.grey,
                              fontSize: 20)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Target weight
                    const Text("Target weight : ",
                        style: TextStyle(
                            color: Color(0xFFD18B81),
                            fontFamily: 'ubuntu',
                            fontSize: 18)),
                    TextFormField(
                      cursorColor: const Color(0xFFD18B81),
                      style: const TextStyle(
                        fontFamily: 'ubuntu',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || int.parse(value) >= 200) {
                          return 'Invalid wight ';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _weights['target_weight'] = input.toString();
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD18B81))),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: "Enter your target weight",
                          hintStyle: TextStyle(
                              fontFamily: 'ubuntu',
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
      ),
    );
  }
}
