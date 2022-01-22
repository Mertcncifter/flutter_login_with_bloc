import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loginbloc/feature/session/data/session_repository.dart';
import 'package:loginbloc/feature/session/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final SessionRepository? sessionRepo;
  User get currentUser => (state as Authenticated).user;
  late User user;
  SessionCubit({this.sessionRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      if (await sessionRepo!.attemptAutoLogin()) {
        User user = User(
          uid: prefs!.getString("uid"),
          phone: prefs!.getString("phone"),
        );
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticad());
      }
    } on Exception {
      emit(Unauthenticad());
    }
  }

  void showSession(User userDetail) {
    user = User(
      uid: userDetail.uid,
      phone: userDetail.phone,
    );
    emit(Authenticated(user: user));
  }

  void signOut() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.clear();
    await sessionRepo!.signOut();
    emit(Unauthenticad());
  }
}
