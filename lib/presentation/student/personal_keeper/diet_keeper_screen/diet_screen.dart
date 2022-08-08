import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/personal_traker/diet_cubit.dart';

class DietScreeen extends StatefulWidget {
  const DietScreeen({Key? key}) : super(key: key);

  @override
  State<DietScreeen> createState() => _DietScreeenState();
}

class _DietScreeenState extends State<DietScreeen> {
  Future<void> getDietData() async {
    await BlocProvider.of<DietCubit>(context).retrieveDietData();
  }

  @override
  void initState() {
    getDietData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getDietData();
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
          BlocBuilder<DietCubit, DietState>(builder: (context, state) {
            if (state is DietRetrieved) {
              return const SizedBox();
            } else if (state is DietInitial) {
              return const SizedBox();
            } else {
              return IconButton(
                  tooltip: "add diet data",
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
          'Diet',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 30),
        ),
      ),
      body: BlocBuilder<DietCubit, DietState>(
        builder: (context, state) {
          if (state is DietRetrieved) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
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
                                Icons.boy_rounded,
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
                                  'Diet Data',
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
                                      'Start Weight : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'ubuntu',
                                          fontSize: 20),
                                    ),
                                    Text(
                                      (state).diet.startWeight + ' kg',
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
                                      'Target Weight : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'ubuntu',
                                          fontSize: 20),
                                    ),
                                    Text(
                                      (state).diet.targetWeight + ' kg',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'ubuntu',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'You need to lose : ' +
                                      (int.parse((state).diet.startWeight) -
                                              int.parse(
                                                  (state).diet.targetWeight))
                                          .toString() +
                                      ' kg',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD18B81),
                                      fontFamily: 'ubuntu',
                                      fontSize: 20),
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
                                  DateTime(0, int.parse((state).diet.month))),
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
                  )
                ],
              ),
            );
          } else if (state is DietInitial) {
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
                  'Start your diet by adding some information now ! ',
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
                      Navigator.pushNamed(context, addDietData);
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
