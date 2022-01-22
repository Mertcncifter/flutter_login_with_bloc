import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginbloc/constants/app_resource_constants.dart';
import 'package:loginbloc/feature/form_submission/form_submission_status.dart';
import 'package:loginbloc/feature/login/bloc/login_bloc.dart';
import 'package:loginbloc/feature/session/cubit/session_cubit.dart';
import 'package:loginbloc/feature/session/data/session_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var sessionRepository = SessionRepository();
  Future<bool> onBackKey() async {
    return false;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackKey,
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
              LoginBloc(sessionRepository, context.read<SessionCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _loginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text('Hata'),
                    content: Text(formStatus.exception.toString()),
                  ));
        } else if (formStatus is SubmissionSuccess) {
          Navigator.pushNamed(context, '/');
        }
      },
      child: Form(
          key: _formKey,
          child: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _phoneField(),
                      _passwordField(),
                      _loginButton(),
                    ],
                  )))),
    );
  }

  Widget _phoneField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPhoneChanged(phone: value));
          },
          validator: (value) => state.isvalidPhone ? null : '',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              fillColor: ResourceConstants.textFormFieldColor,
              filled: true,
              errorStyle: TextStyle(fontSize: 0),
              prefixIcon: Icon(FontAwesomeIcons.phone,
                  color: ResourceConstants.textformFieldIconColor),
              errorBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldErrorBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        ResourceConstants.textformFieldFocusedErrorBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldFocusBorderColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldDisableBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldEnabledBorderColor),
              ),
              hintText: "Phone"));
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value));
          },
          validator: (value) => state.isValidPassword ? null : '',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              fillColor: ResourceConstants.textFormFieldColor,
              filled: true,
              errorStyle: TextStyle(fontSize: 0),
              prefixIcon: Icon(FontAwesomeIcons.lock,
                  color: ResourceConstants.textformFieldIconColor),
              errorBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldErrorBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        ResourceConstants.textformFieldFocusedErrorBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldFocusBorderColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldDisableBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ResourceConstants.textformFieldEnabledBorderColor),
              ),
              hintText: "Password"));
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Text("Login"));
    });
  }
}
