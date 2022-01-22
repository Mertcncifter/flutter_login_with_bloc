import 'package:flutter/material.dart';
import 'package:loginbloc/presentations/screens/auth/auth_screen.dart';
import 'package:loginbloc/presentations/screens/auth/login_screens.dart';
import 'package:loginbloc/presentations/screens/home/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (authScreenContext) => AuthScreen(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (loginScreenContext) => LoginScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (loginScreenContext) => HomeScreen(),
        );
    }
  }
}
