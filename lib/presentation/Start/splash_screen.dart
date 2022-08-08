import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/auth_cubit.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void autoLogin() async{
     await BlocProvider.of<AuthCubit>(context).tryAutoLogin();
  }
  @override
  void initState() {
   autoLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "Mokhatat",
                  style: TextStyle(
                      color: Color(0xFFD18B81),
                      fontSize: 50,
                      fontFamily: 'picobla'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: SpinKitCircle(
                color: Color(0xFFD18B81),
                size: 40,
              ))
            ],
          )),
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.of(context).pushReplacementNamed(startScreen);
        } else if (state is AuthSucceed) {
           Navigator.of(context).pushReplacementNamed(homePage);
        }
      },
    );
  }
}
