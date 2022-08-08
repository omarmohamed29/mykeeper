import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/logic/cubit/personal_traker/budget_cubit.dart';
import 'package:mokhatat/logic/cubit/personal_traker/diet_cubit.dart';
import 'package:mokhatat/logic/cubit/user_cubit.dart';
import 'package:mokhatat/presentation/widgets/personal_keeper/budget_widget.dart';
import 'package:mokhatat/presentation/widgets/personal_keeper/diet_widget.dart';
import 'package:mokhatat/presentation/widgets/drawer.dart';
import 'package:mokhatat/presentation/widgets/user_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getinitialtData() async {
    await BlocProvider.of<DietCubit>(context).retrieveDietData();
    await BlocProvider.of<BudgetCubit>(context).retrieveBudgetData();
    await BlocProvider.of<UserCubit>(context).retrieveDietData();
  }

  @override
  void initState() {
    getinitialtData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFD18B81)),
        title: const Text(
          'Mokhatat',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'ubuntu',
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81)),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      drawer: const MyDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: userWidget(context),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              DateFormat('EEEE , dd / MMMM yyy').format(DateTime.now()),
              style: const TextStyle(
                  color: Color(0xFFD18B81), fontFamily: 'ubuntu', fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Personal",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline2!.color,
                  fontFamily: 'ubuntu',
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: dietWidget(context),
                ),
                const SizedBox(
                  width: 5,
                ),
                budgetWidget(context),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
