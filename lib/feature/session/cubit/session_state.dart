part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();
  @override
  List<Object> get props => [];
}

class UnknownSessionState extends SessionState {
  const UnknownSessionState();
}

class Unauthenticad extends SessionState {
  const Unauthenticad();
}

class Authenticated extends SessionState {
  final User user;
  const Authenticated({required this.user});
}
