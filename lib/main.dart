import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokhatat/data/repository/auth_repository.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/repository/user_repository.dart';
import 'package:mokhatat/data/webservice/auth_webservice.dart';
import 'package:mokhatat/data/webservice/user_webService.dart';
import 'package:mokhatat/logic/cubit/auth_cubit.dart';
import 'package:mokhatat/logic/cubit/user_cubit.dart';

import 'global/app_router.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  final AuthCubit authCubit =
      AuthCubit(AuthRepo(AuthWebservice()), Sharedprefs());
  final UserCubit userCubit = UserCubit(
    UserRepo(UserWebservice(Sharedprefs())),
    UserWebservice(Sharedprefs()),
  );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => authCubit,
        ),
        BlocProvider<UserCubit>(
          create: (context) => userCubit,
        ),
      ],
      child: MaterialApp(
        title: 'Mokhatat',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
