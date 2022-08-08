import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/personal_traker/budget_cubit.dart';

Widget budgetWidget(BuildContext context) {
  return BlocBuilder<BudgetCubit, BudgetState>(builder: ((context, state) {
    if (state is BudgetRetrieved) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, budgetScreen);
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
                    Icons.attach_money_rounded,
                    color: const Color(0xFFD18B81).withOpacity(0.1),
                    size: 200,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Text(
                    'Budget',
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
                        "Incoming money : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: ' ubuntu',
                            fontSize: 18),
                      ),
                      Text(
                        state.budget.incomingMoney + ' EGP',
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
                        "Spent money : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: ' ubuntu',
                            fontSize: 18),
                      ),
                      Text(
                        state.budget.spentMoney + ' EGP',
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
                    'You Saved : ' +
                        (int.parse((state).budget.incomingMoney) -
                                int.parse((state).budget.spentMoney))
                            .toString() +
                        ' EGP',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD18B81),
                        fontFamily: 'ubuntu',
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (state is BudgetInitial) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, budgetScreen);
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
                  Icons.attach_money_rounded,
                  color: Theme.of(context).textTheme.headline2!.color,
                  size: 25,
                ),
                Text(
                  'track your budget ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline2!.color,
                      fontFamily: ' ubuntu',
                      fontSize: 20),
                ),
                const Text(
                  'track your incoming and spending money through the month to save some',
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
