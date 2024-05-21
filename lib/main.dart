import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'core/routes/main_router.dart';
import 'presentation/blocs/comment/comment_bloc.dart';
import 'presentation/blocs/diary/current_diary_bloc.dart';
import 'presentation/blocs/diary/pub_diary_bloc.dart';
import 'presentation/blocs/main/bottom_navigation_bar_cubit.dart';
import 'presentation/blocs/main/drag_route_cubit.dart';
import 'presentation/blocs/main/navigator_key_cubit.dart';
import 'presentation/blocs/main/second_navigation_bar_cubit.dart';
import 'locator.dart' as di;
import 'presentation/blocs/member/member_bloc.dart';
import 'presentation/blocs/pip/segment_toggle/segment_toggle_cubit.dart';
import 'presentation/blocs/search/search_diary_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initializeDependencies();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runApp(MyApp(navigatorKey: navigatorKey));
  configLoading();
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({required this.navigatorKey, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DragRouteCubit>(create: (_) => DragRouteCubit()),
        BlocProvider<BottomNavigationBarCubit>(
            create: (_) => BottomNavigationBarCubit()),
        BlocProvider<NavigatorKeyCubit>(
            create: (_) => NavigatorKeyCubit(navigatorKey)),
        BlocProvider(create: (_) => SegmentToggleCubit()),
        BlocProvider(create: (_) => SecondNavigationBarCubit()),
        BlocProvider(create: (_) => di.sl<MemberBloc>()..add(CheckMember())),
        BlocProvider(create: (_) => di.sl<PubDiaryBloc>()),
        BlocProvider(create: (_) => di.sl<CurrentDiaryBloc>()),
        BlocProvider(create: (_) => di.sl<CommentBloc>()),
        BlocProvider(create: (_) => di.sl<SearchDiaryBloc>())
      ],
      child: KeyboardDismisser(
        gestures: const [GestureType.onTap],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
            builder: EasyLoading.init(),
          // initialRoute: AppRouter.signIn,
        ),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
