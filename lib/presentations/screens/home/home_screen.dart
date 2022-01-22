import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/feature/session/cubit/session_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var user = context.read<SessionCubit>().currentUser;
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user.phone.toString()),
          Text(user.uid.toString()),
          TextButton(
              onPressed: () {
                context.read<SessionCubit>().signOut();
              },
              child: Text("SignOut"))
        ],
      )),
    );
  }
}
