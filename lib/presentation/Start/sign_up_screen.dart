// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/logic/cubit/auth_cubit.dart';
import 'package:mokhatat/logic/cubit/user_cubit.dart';
import 'package:mokhatat/presentation/Start/sign_in_screen.dart';
import 'package:mokhatat/presentation/homepage.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    'phoneNumber': '',
    'address': '',
  };

  int currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _infoKey = GlobalKey<FormState>();
  bool _passLook = true;
  bool _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _authSignUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<AuthCubit>(context).authenticate(
            _authData['email'].toString(),
            _authData['password'].toString(),
            'signupNewUser');
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> _completeSignUp() async {
    if (_infoKey.currentState!.validate()) {
      _infoKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<UserCubit>(context).addUser(
            _authData['name'].toString(),
            _authData['address'].toString(),
            _authData['email'].toString(),
            _authData['phoneNumber'].toString());
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
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
            }
          },
        ),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserAdded) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text('Something went wrong'),
                        content: const Text(
                            'please check your internet connection then try again'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Okay'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ));
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                colorScheme:
                    const ColorScheme.light(primary: Color(0xFFD18B81))),
            child: Stepper(
              type: StepperType.horizontal,
              elevation: 0.0,
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == 1;
                if (isLastStep) {
                  _completeSignUp();
                } else if (_formKey.currentState!.validate()) {
                  _authSignUp();
                  setState(() => currentStep += 1);
                }
              },
              onStepCancel: () {
                currentStep == 0 ? null : setState(() => currentStep -= 1);
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: _isLoading ? null : details.onStepCancel,
                          child: const Text(
                            'Go back',
                          ),
                        ),
                        MaterialButton(
                          onPressed: details.onStepContinue,
                          color: const Color(0xFFD18B81),
                          height: 50,
                          minWidth: 150,
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
                                : Center(
                                    child: Row(
                                      children: const [
                                        Text(
                                          "continue",
                                          style: TextStyle(
                                              fontFamily: 'ubuntu',
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              steps: [
                Step(
                  isActive: currentStep >= 0,
                  title: Text("Authentication"),
                  content: Form(
                    key: _formKey,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Welcome to ",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .color,
                                        fontSize: 28,
                                        fontFamily: 'picobla'),
                                  ),
                                  Text(
                                    "Mokhatat",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .color,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'picobla'),
                                  ),
                                ],
                              ),
                              const Text(
                                "let's get some basic info.",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontFamily: 'picobla'),
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
                                        borderSide: BorderSide(
                                            color: Color(0xFFD18B81))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide()),
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
                              TextFormField(
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
                                        borderSide: BorderSide(
                                            color: Color(0xFFD18B81))),
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
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Confirm password",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'ubuntu',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey),
                                )),
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontFamily: 'ubuntu',
                                  ),
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return 'Password do not match !';
                                    }
                                  },
                                  onSaved: (input) {
                                    _authData['password'] = input.toString();
                                  },
                                  obscureText: _passLook,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFD18B81))),
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
                                          "Make sure to enter the same password",
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "If you already have an account you can  ",
                                      style: TextStyle(
                                          fontFamily: 'ubuntu',
                                          color: Color(0xFFD18B81),
                                          fontSize: 15),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const SignIn()));
                                        },
                                        child: const Text("Sign in",
                                            style: TextStyle(
                                                fontFamily: 'ubuntu',
                                                color: Color(0xFFD18B81),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),

                //step 2  information gathering
                Step(
                  isActive: currentStep >= 1,
                  title: const Text(
                    'Complete your info ...',
                  ),
                  content: Form(
                    key: _infoKey,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Now let's get to know you better",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .color,
                                    fontSize: 20,
                                    fontFamily: 'picobla'),
                              ),
                              const Text(
                                "Fill more useful information ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontFamily: 'picobla'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Name",
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
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty || value.contains('@')) {
                                    return 'Invalid name ';
                                  }
                                  return null;
                                },
                                onSaved: (input) {
                                  _authData['name'] = input.toString();
                                },
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFD18B81))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    hintText: "Tell us your name",
                                    hintStyle: TextStyle(
                                        fontFamily: 'ubuntu',
                                        color: Colors.grey,
                                        fontSize: 12.0)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Phone number",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'ubuntu',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(
                                  fontFamily: 'ubuntu',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 11) {
                                    return 'this is not a valid number';
                                  }
                                },
                                onSaved: (input) {
                                  _authData['phoneNumber'] = input.toString();
                                },
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFD18B81))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    hintText: "now a mobile number please",
                                    hintStyle: TextStyle(
                                        fontFamily: 'ubuntu',
                                        color: Colors.grey,
                                        fontSize: 12.0)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Address",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'ubuntu',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey),
                                )),
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontFamily: 'ubuntu',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty || value.contains('@')) {
                                      return 'the address you entered is empty or contains error';
                                    }
                                  },
                                  onSaved: (input) {
                                    _authData['address'] = input.toString();
                                  },
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFD18B81))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()),
                                      hintText: "Tell us where do you live",
                                      hintStyle: TextStyle(
                                          fontFamily: 'ubuntu',
                                          color: Colors.grey,
                                          fontSize: 12.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
