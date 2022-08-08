import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/personal_traker/diet_cubit.dart';

Widget dietWidget(BuildContext context) {
  return BlocBuilder<DietCubit, DietState>(builder: ((context, state) {
    if (state is DietRetrieved) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, dietScreen);
        },
        child: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Icon(
                    Icons.sports_gymnastics_rounded,
                    color: const Color(0xFFD18B81).withOpacity(0.1),
                    size: 200,
                  ),
                ),
                 Positioned(
                  left: 10,
                  top: 10,
                  child: Text(
                    'Current diet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline2!.color,
                        fontFamily: ' ubuntu',
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Row(
                    children: [
                     const Text(
                        "Start weight : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: ' ubuntu',
                            fontSize: 18),
                      ),
                      Text(
                        state.diet.startWeight + ' kg',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: ' ubuntu',
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 13,
                  child: Row(
                    children: [
                      const Text(
                        "Target weight : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: ' ubuntu',
                            fontSize: 18),
                      ),
                      Text(
                        state.diet.targetWeight + ' kg',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: ' ubuntu',
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 115,
                  left: 50,
                  right: 50,
                  child: Text(
                    'You need to lose : ' +
                        (int.parse((state).diet.startWeight) -
                                int.parse((state).diet.targetWeight))
                            .toString() +
                        ' kg',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD18B81),
                        fontFamily: 'ubuntu',
                        fontSize: 12),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text(
                    DateFormat('MMMM')
                        .format(DateTime(0, int.parse((state).diet.month))),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontFamily: ' ubuntu',
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (state is DietInitial) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, dietScreen);
        },
        child: Container(
            height: 300,
            width: 250,
            decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_gymnastics_rounded,
                  color: Theme.of(context).textTheme.headline2!.color,
                  size: 25,
                ),
                Text(
                  'track your diet ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline2!.color,
                      fontFamily: ' ubuntu',
                      fontSize: 20),
                ),
                const Text(
                  'you can start by adding your diet data by  clicking here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: ' ubuntu',
                      fontSize: 12),
                ),
              ],
            )),
      );
    }
  }));
}
