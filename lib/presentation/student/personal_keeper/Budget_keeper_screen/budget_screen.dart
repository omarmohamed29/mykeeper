import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/personal_traker/budget_cubit.dart';
import 'package:mokhatat/presentation/student/personal_keeper/Budget_keeper_screen/edit_budget_data.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  Future<void> getBudgetData() async {
    await BlocProvider.of<BudgetCubit>(context).retrieveBudgetData();
  }

  @override
  void initState() {
    getBudgetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      getBudgetData();
    });

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
        actions: <Widget>[
          BlocConsumer<BudgetCubit, BudgetState>(
            listener: (context , state){
              if(state is EditBudgetData){
                getBudgetData();
              }
            },
            builder: (context, state) {
            if (state is BudgetRetrieved) {
              return IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, editBudgetData);
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 30,
                    color: Color(0xFFDF7861),
                  ));
            } else if (state is BudgetInitial) {
              return const SizedBox();
            } else {
              return IconButton(
                  tooltip: "add budget data",
                  onPressed: () {
                    Navigator.pushNamed(context, addDietData);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                    color: Color(0xFFDF7861),
                  ));
            }
          })
        ],
        title: const Text(
          'Budget',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 30),
        ),
      ),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state is BudgetRetrieved) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color(0xFFB0C6CD),
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          const Positioned(
                              bottom: 0,
                              right: 0,
                              child: Opacity(
                                opacity: 0.2,
                                child: Icon(
                                  Icons.attach_money_rounded,
                                  size: 200,
                                ),
                              )),
                          Positioned(
                            left: 10,
                            top: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Budget Data',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'ubuntu',
                                        fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'incoming : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'ubuntu',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        (state).budget.incomingMoney + ' EGP',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'ubuntu',
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Spent : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'ubuntu',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        (state).budget.spentMoney + ' EGP',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'ubuntu',
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Saved : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'ubuntu',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        (int.parse((state)
                                                        .budget
                                                        .incomingMoney) -
                                                    int.parse((state)
                                                        .budget
                                                        .spentMoney))
                                                .toString() +
                                            ' EGP',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'ubuntu',
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat('MMMM').format(
                                    DateTime(0, int.parse((state).budget.month))),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'ubuntu',
                                    fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is BudgetInitial) {
            return const SizedBox();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoAlertDialog(
                title: const Text(
                  'Note',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD18B81),
                      fontFamily: 'ubuntu',
                      fontSize: 20),
                ),
                content: const Text(
                  'track your incoming and spending money through the month to save some',
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
                      Navigator.pushNamed(context, addBudgetData);
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
