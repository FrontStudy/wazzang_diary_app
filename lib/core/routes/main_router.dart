import 'package:flutter/material.dart';

import '../../presentation/pages/authentication/signin_page.dart';
import '../../presentation/pages/main_page.dart';
import '../error/exceptions.dart';

class AppRouter {
  static const String main = '/';

  static const String signIn = '/sign-in';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
