// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/auth_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passLook = true;
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  Future<void> _authSignIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<AuthCubit>(context).authenticate(
            _authData['email'].toString(),
            _authData['password'].toString(),
            'verifyPassword');
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
    return BlocListener<AuthCubit, AuthState>(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Mokhatat",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .color,
                                fontSize: 50,
                                fontFamily: 'picobla'),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Sign-In",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .color,
                                fontSize: 25,
                                fontFamily: 'ubuntu'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontFamily: 'ubuntu',
                                fontSize: 20)),
                        TextFormField(
                          cursorColor: const Color(0xFFD18B81),
                          style: const TextStyle(
                            fontFamily: 'ubuntu',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Invalid Email ';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _authData['email'] = input.toString();
                          },
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD18B81))),
                              border:
                                  OutlineInputBorder(borderSide: BorderSide()),
                              hintText: "Give us your Email please ! ",
                              hintStyle: TextStyle(
                                  fontFamily: 'ubuntu',
                                  color: Colors.grey,
                                  fontSize: 12.0)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Password",
                            style: TextStyle(
                                color: Colors.black45,
                                fontFamily: 'ubuntu',
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 0.5, color: Colors.grey),
                          )),
                          child: TextFormField(
                            controller: _passwordController,
                            style: const TextStyle(
                              fontFamily: 'ubuntu',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Password is too short !';
                              }
                            },
                            onSaved: (input) {
                              _authData['password'] = input.toString();
                            },
                            obscureText: _passLook,
                            decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD18B81))),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide()),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passLook = !_passLook;
                                    });
                                  },
                                  child: Icon(
                                    _passLook
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20,
                                    color: const Color(0xFFD18B81),
                                  ),
                                ),
                                hintText:
                                    "Your password is hidden we won't sneak ",
                                hintStyle: const TextStyle(
                                    fontFamily: 'ubuntu',
                                    color: Colors.grey,
                                    fontSize: 12.0)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: MaterialButton(
                          onPressed: _authSignIn,
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
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'ubuntu',
                                          color: Colors.white,
                                          fontSize: 23),
                                    ),
                                  ),
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account ?!  ",
                                style: TextStyle(
                                    fontFamily: 'ubuntu',
                                    color: Color(0xFFD18B81),
                                    fontSize: 15),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, signup);
                                  },
                                  child: const Text("SignUp",
                                      style: TextStyle(
                                          fontFamily: 'ubuntu',
                                          color: Color(0xFFD18B81),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
      listener: ((context, state) {
        if (state is AuthError) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text('An error Occured!'),
                    content: Text((state).error.toString()),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        } else if (state is AuthSucceed) {
          Navigator.pushNamed(context, homePage);
        }
      }),
    );
  }
}
