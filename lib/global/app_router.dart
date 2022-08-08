// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/data/model/habits/habit_tracker_local_point.dart';
import 'package:mokhatat/data/repository/HabitTrackerRepository.dart';
import 'package:mokhatat/data/repository/book_shelf_repository.dart';
import 'package:mokhatat/data/repository/budgetRepository.dart';
import 'package:mokhatat/data/repository/class_schedule_repository.dart';
import 'package:mokhatat/data/repository/datesTorememberRepository.dart';
import 'package:mokhatat/data/repository/dietRepository.dart';
import 'package:mokhatat/data/repository/goal_repository.dart';
import 'package:mokhatat/data/repository/habits_repository.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/repository/user_repository.dart';
import 'package:mokhatat/data/webservice/HabitTreacker_webService.dart';
import 'package:mokhatat/data/webservice/book_shelf_webservice.dart';
import 'package:mokhatat/data/webservice/budget_webService.dart';
import 'package:mokhatat/data/webservice/class_schedule_webservice.dart';
import 'package:mokhatat/data/webservice/dates_to_remember_webservice.dart';
import 'package:mokhatat/data/webservice/dietWebService.dart';
import 'package:mokhatat/data/webservice/goal_webservice.dart';
import 'package:mokhatat/data/webservice/habit_webService.dart';
import 'package:mokhatat/data/webservice/user_webService.dart';
import 'package:mokhatat/logic/cubit/book_shelf/bookshelf_cubit.dart';
import 'package:mokhatat/logic/cubit/class_schedule/class_schedule_cubit.dart';
import 'package:mokhatat/logic/cubit/dates_to_remember/dates_to_remember_cubit.dart';
import 'package:mokhatat/logic/cubit/goal/goal_cubit.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/add_habit_cubit.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/habit_screen_cubit.dart';
import 'package:mokhatat/logic/cubit/habit_tracker/habit_tracker_cubit.dart';
import 'package:mokhatat/logic/cubit/personal_traker/budget_cubit.dart';
import 'package:mokhatat/logic/cubit/personal_traker/diet_cubit.dart';
import 'package:mokhatat/logic/cubit/user_cubit.dart';
import 'package:mokhatat/presentation/Start/sign_in_screen.dart';
import 'package:mokhatat/presentation/Start/sign_up_screen.dart';
import 'package:mokhatat/presentation/Start/splash_screen.dart';
import 'package:mokhatat/presentation/Start/starter.dart';
import 'package:mokhatat/presentation/homepage.dart';
import 'package:mokhatat/presentation/student/book_shelf/add_new_book.dart';
import 'package:mokhatat/presentation/student/book_shelf/book_shelf.dart';
import 'package:mokhatat/presentation/student/dates_to_remember/dates_to_remember_screen.dart';
import 'package:mokhatat/presentation/student/goals/goals_screen.dart';
import 'package:mokhatat/presentation/student/goals/manage_goals_screen.dart';
import 'package:mokhatat/presentation/student/habit_tracker/add_habits_screen.dart';
import 'package:mokhatat/presentation/student/habit_tracker/habit_tracker_screen.dart';
import 'package:mokhatat/presentation/student/monthly_time_table/add_class_details.dart';
import 'package:mokhatat/presentation/student/monthly_time_table/add_class_schedule.dart';
import 'package:mokhatat/presentation/student/monthly_time_table/monthly_time_table.dart';
import 'package:mokhatat/presentation/student/personal_keeper/Budget_keeper_screen/add_budget_data.dart';
import 'package:mokhatat/presentation/student/personal_keeper/Budget_keeper_screen/budget_screen.dart';
import 'package:mokhatat/presentation/student/personal_keeper/Budget_keeper_screen/edit_budget_data.dart';
import 'package:mokhatat/presentation/student/personal_keeper/diet_keeper_screen/add_diet_data.dart';
import 'package:mokhatat/presentation/student/personal_keeper/diet_keeper_screen/diet_screen.dart';
import 'package:mokhatat/presentation/student/personal_keeper/diet_keeper_screen/edit_diet_data.dart';
import 'package:mokhatat/presentation/widgets/monthly_time_table/class_schedule_widget.dart';

import '../presentation/student/dates_to_remember/add_date_to_remember_screen.dart';

class AppRouter {
  final Sharedprefs sharedprefs = Sharedprefs();
  late DatesToRememberWebService datesToRememberWebService =
      DatesToRememberWebService(sharedprefs);
  late DatesToRememberCubit datesToRememberCubit = DatesToRememberCubit(
      DatesToRememberRepo(DatesToRememberWebService(sharedprefs)),
      DatesToRememberWebService(sharedprefs));
  late HabitTrackerCubit habitTrackerCubit = HabitTrackerCubit(
      HabitTrackerRepo(sharedprefs, HabitTrackerWebService(sharedprefs)));
  late AddHabitCubit addHabitCubit =
      AddHabitCubit(HabitsRepo(HabitWebService(sharedprefs), sharedprefs));
  late DietCubit dietCubit = DietCubit(DietWebService(sharedprefs),
      DietRepo(sharedprefs, DietWebService(sharedprefs)));
  late BudgetCubit budgetCubit = BudgetCubit(BudgetWebService(sharedprefs),
      BudgetRepo(sharedprefs, BudgetWebService(sharedprefs)));
  late BookshelfCubit bookshelfCubit = BookshelfCubit(
      BookShelfWebService(sharedprefs: sharedprefs),
      BookShelfRepo(
          sharedprefs, BookShelfWebService(sharedprefs: sharedprefs)));
  late GoalCubit goalCubit = GoalCubit(GoalWebService(sharedprefs),
      GoalRepo(sharedprefs, GoalWebService(sharedprefs)));
  late ClassScheduleCubit classScheduleCubit = ClassScheduleCubit(
      ClassScheduleWebService(sharedprefs),
      ClassScheduleRepo(sharedprefs, ClassScheduleWebService(sharedprefs)));
  late UserCubit userCubit = UserCubit(
      UserRepo(UserWebservice(sharedprefs)), UserWebservice(sharedprefs));

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const Splashscreen());
      case startScreen:
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case signin:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case homePage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: dietCubit),
                    BlocProvider.value(value: budgetCubit),
                    BlocProvider.value(value: userCubit),
                  ],
                  child: const HomePage(),
                ));
      case datesToRemember:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: datesToRememberCubit,
                  child: const DatesToRemember(),
                ));
      case addDatesToRemember:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: datesToRememberCubit,
                  child: const AddDatesToRemember(),
                ));
      case habitTracker:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: habitTrackerCubit),
              BlocProvider.value(value: HabitScreenCubit(HabitLocal())),
              BlocProvider.value(value: addHabitCubit),
            ],
            child: const HabitTracker(),
          ),
        );
      case addHabitTracker:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: addHabitCubit,
                  child: const AddHabitsScreen(),
                ));

      case bookShelf:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: bookshelfCubit,
                  child: const BookShelfScreen(),
                ));
      case addBookShelf:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: bookshelfCubit,
                  child: const AddNewBook(),
                ));
      case goals:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: goalCubit,
                  child: const GoalsScreen(),
                ));
      case manageGoals:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: goalCubit,
                  child: const ManageGoalsScreen(),
                ));

      //schedule
      case monthlyTimeTable:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: classScheduleCubit,
                  child: const MonthlyTimeTable(),
                ));
      case addMonthlyTimeTable:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: classScheduleCubit,
                  child: const AddClassSchedule(),
                ));
      case classSchedule:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: classScheduleCubit,
                  child: const ClassSchedule(),
                ));
       case addClassDetails:
        return MaterialPageRoute(
            builder: (_) => const AddClassDetails());
        
      //personal keeper screens
      case dietScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: dietCubit,
                  child: const DietScreeen(),
                ));
      case addDietData:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: dietCubit,
                  child: const AddDietData(),
                ));
      case editDietData:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: dietCubit,
                  child: EditDietData(),
                ));
      case budgetScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: budgetCubit,
                  child: const BudgetScreen(),
                ));
      case addBudgetData:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: budgetCubit,
                  child: const AddBudgetData(),
                ));
      case editBudgetData:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: budgetCubit,
                  child: const EditBudgetData(),
                ));
    }
  }
}
