import 'package:flutter/material.dart';

import '../../presentation/pages/main_page.dart';
import '../error/exceptions.dart';

class AppRouter {
  static const String main = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
