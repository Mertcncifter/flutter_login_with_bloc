import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginbloc/presentations/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature/session/cubit/session_cubit.dart';
import 'feature/session/data/session_repository.dart';
import 'helper/bloc_observer.dart';

SharedPreferences? prefs;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(App(
    sessionRepository: SessionRepository(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key, required this.sessionRepository}) : super(key: key);
  final SessionRepository sessionRepository;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SessionCubit>(
          create: (context) => SessionCubit(sessionRepo: sessionRepository)),
    ], child: AppView());
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _router = AppRouter();
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}
