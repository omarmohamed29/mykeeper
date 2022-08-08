import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/logic/cubit/personal_traker/budget_cubit.dart';

class EditBudgetData extends StatefulWidget {
  const EditBudgetData({ Key? key }) : super(key: key);

  @override
  State<EditBudgetData> createState() => _EditBudgetDataState();
}

class _EditBudgetDataState extends State<EditBudgetData> {
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _budget = {
    'incoming_money': '',
    'spent_money': '',
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
        await BlocProvider.of<BudgetCubit>(context).editBudgetData(
            _budget['incoming_money'].toString(),
            _budget['spent_money'].toString(),
            _budget['month'].toString());
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
    return BlocConsumer<BudgetCubit, BudgetState>(
      listener: (context, state) {
        if (state is BudgetDataEdit) {
          Navigator.pop(context);
        }
      },
      builder: (context ,state){
        if(state is BudgetRetrieved){
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
          'Edit your Budget Data',
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
                    const Text("Incoming money : ",
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
                      initialValue: (state).budget.incomingMoney,
                      validator: (value) {
                        if (value!.isEmpty ) {
                          return 'Invalid budget ';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _budget['incoming_money'] = input.toString();
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD18B81))),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: "Enter your incoming budget",
                          hintStyle: TextStyle(
                              fontFamily: 'ubuntu',
                              color: Colors.grey,
                              fontSize: 12)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Target weight
                    const Text("Spent money : ",
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
                      initialValue: (state).budget.spentMoney,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid budget ';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _budget['spent_money'] = input.toString();
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD18B81))),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: "Enter the  money you spent",
                          hintStyle: TextStyle(
                              fontFamily: 'ubuntu',
                              color: Colors.grey,
                              fontSize: 12)),
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
        }else{
          return const SizedBox();
        }
      }
    );
  }
}