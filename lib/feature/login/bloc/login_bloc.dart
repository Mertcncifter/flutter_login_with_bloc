import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loginbloc/feature/form_submission/form_submission_status.dart';
import 'package:loginbloc/feature/session/cubit/session_cubit.dart';
import 'package:loginbloc/feature/session/data/session_repository.dart';
import 'package:loginbloc/feature/session/model/User.dart';

import '../../../main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionRepository sessionRepo;
  final SessionCubit sessionCubit;
  LoginBloc(this.sessionRepo, this.sessionCubit) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPhoneChanged) {
      yield state.copyWith(phone: event.phone);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final jsonStr = await sessionRepo.login(state.phone, state.password);
        dynamic jsonDyn = json.decode(jsonStr.toString());
        if (jsonDyn["success"]) {
          yield state.copyWith(formStatus: SubmissionSuccess());
          sessionCubit.showSession(User(
            phone: state.phone,
            uid: prefs!.getString("uid"),
          ));
        } else {
          yield state.copyWith(
              formStatus:
                  SubmissionFailed(exception: jsonDyn["message"].toString()));
          yield state.copyWith(formStatus: InitialFormStatus());
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
