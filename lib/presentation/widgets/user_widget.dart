import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokhatat/logic/cubit/user_cubit.dart';

Widget userWidget(BuildContext context) {
  return BlocBuilder<UserCubit, UserState>(
    builder: (context, state) {
      if (state is UserRetrieved) {
        return Row(
          children: [
            const Text(
              "Welcome , ",
              style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  color:  Color(0xFFD18B81),
                  fontFamily: 'ubuntu',
                  fontSize: 20),
            ),
            Text(
              (state).user.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color:  Color(0xFFD18B81),
                  fontFamily: 'ubuntu',
                  fontSize: 20),
            ),
            const Icon(
              Icons.tag_faces,
              color:  Color(0xFFD18B81),
            )
          ],
        );
      } else if (state is UserInitial) {
        return const SizedBox();
      } else {
        return const SizedBox();
      }
    },
  );
}
