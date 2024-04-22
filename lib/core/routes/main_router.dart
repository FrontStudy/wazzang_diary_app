import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/signup/check_email_bloc.dart';
import '../../presentation/pages/authentication/signin_page.dart';
import '../../presentation/pages/authentication/signup_birth_page.dart';
import '../../presentation/pages/authentication/signup_name_page.dart';
import '../../presentation/pages/authentication/signup_nickname_page.dart';
import '../../presentation/pages/authentication/signup_page.dart';
import '../../presentation/pages/authentication/signup_pw_page.dart';
import '../../presentation/pages/authentication/signup_terms_page.dart';
import '../../presentation/pages/main_page.dart';
import '../error/exceptions.dart';

import '../../locator.dart' as di;

class AppRouter {
  static const String main = '/';

  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String signUpPw = '/sign-up-pw';
  static const String signUpBirth = '/sign-up-birth';
  static const String signUpName = '/sign-up-name';
  static const String signUpNickName = '/sign-up-nickname';
  static const String signUpTerms = '/sign-up-terms';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case signUp:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => CheckEmailBloc(di.sl()),
                child: const SignUpPage()));
      case signUpPw:
        final Map<String, dynamic> memberInfo =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SignUpPwPage(info: memberInfo));
      case signUpBirth:
        final Map<String, dynamic> memberInfo =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SignUpBirthPage(info: memberInfo));
      case signUpName:
        final Map<String, dynamic> memberInfo =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SignUpNamePage(info: memberInfo));
      case signUpNickName:
        final Map<String, dynamic> memberInfo =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SignUpNicknamePage(info: memberInfo));
      case signUpTerms:
        final Map<String, dynamic> memberInfo =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SignUpTermsPage(info: memberInfo));

      default:
        throw const RouteException('Route not found!');
    }
  }
}
