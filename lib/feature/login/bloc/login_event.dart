part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginPhoneChanged extends LoginEvent {
  final String phone;
  LoginPhoneChanged({required this.phone});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}
