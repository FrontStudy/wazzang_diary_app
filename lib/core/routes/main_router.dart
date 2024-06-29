import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/signup/check_email_bloc.dart';
import '../../presentation/blocs/signup/profile_image_bloc.dart';
import '../../presentation/pages/account/account_page.dart';
import '../../presentation/pages/authentication/signin_page.dart';
import '../../presentation/pages/authentication/signup_birth_page.dart';
import '../../presentation/pages/authentication/signup_name_page.dart';
import '../../presentation/pages/authentication/signup_nickname_page.dart';
import '../../presentation/pages/authentication/signup_page.dart';
import '../../presentation/pages/authentication/signup_profile_page.dart';
import '../../presentation/pages/authentication/signup_pw_page.dart';
import '../../presentation/pages/authentication/signup_terms_page.dart';
import '../../presentation/pages/main_page.dart';
import '../../presentation/pages/write_diary/select_diary_image_page.dart';
import '../error/exceptions.dart';

import '../../locator.dart' as di;

class AppRouter {
  static const String main = '/main';

  static const String signIn = '/';
  static const String signUp = '/sign-up';
  static const String signUpPw = '/sign-up-pw';
  static const String signUpBirth = '/sign-up-birth';
  static const String signUpName = '/sign-up-name';
  static const String signUpNickName = '/sign-up-nickname';
  static const String signUpTerms = '/sign-up-terms';
  static const String signUpProfile = '/sign-up-profile';
  static const String account = '/account';
  static const String signOut = '/signOut';
  static const String writeDiary = '/writeDiary';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case signIn:
      case signOut:
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
      case signUpProfile:
        final Map<String, dynamic> memberInfo =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => ProfileImageBloc(di.sl()),
                child: SignUpProfilePage(info: memberInfo)));
      case account:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AccountPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case writeDiary:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Builder(
              builder: (_) => BlocProvider(
                  create: (context) => ProfileImageBloc(di.sl()),
                  child: const SelectDiaryImage())),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
