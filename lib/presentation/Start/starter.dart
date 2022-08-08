import 'package:flutter/material.dart';
import 'package:mokhatat/presentation/Start/sign_in_screen.dart';
import 'package:mokhatat/presentation/Start/sign_up_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Mokhatat",
              style: TextStyle(
                  color: Color(0xFFD18B81),
                  fontSize: 50,
                  fontFamily: 'picobla'),
            ),
            Text(
              "Hello there ,",
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline2!.color,
                  fontSize: 25,
                  fontFamily: 'ubuntu'),
            ),
            Text(
              "welcome to your favourite application",
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline2!.color,
                  fontSize: 18,
                  fontFamily: 'ubuntu'),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: InkWell(
                    child: Image.asset(
                  'assets/images/start_screen.jpg',
                  fit: BoxFit.contain,
                )),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(MediaQuery.of(context).size.width - 50, 60),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const SignIn()));
              },
              child: Text(
                'Log in ',
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline2!.color,
                    fontSize: 25,
                    fontFamily: 'ubuntu'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shadowColor: const Color(0xFFD18B81),
                backgroundColor: const Color(0xFFD18B81),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(MediaQuery.of(context).size.width - 50, 60),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const SignUp()));
              },
              child: const Text(
                'Sign up ',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: 'ubuntu'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
