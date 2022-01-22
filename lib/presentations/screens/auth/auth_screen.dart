import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/feature/session/cubit/session_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: BlocConsumer<SessionCubit, SessionState>(
                        builder: (context, state) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }, listener: (context, state) {
                      if (state is Unauthenticad) {
                        Navigator.pushNamed(context, '/login');
                      } else if (state is Authenticated) {
                        Navigator.pushNamed(context, '/home');
                      }
                    })))));
  }
}
