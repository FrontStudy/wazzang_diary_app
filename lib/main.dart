import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/main_router.dart';
import 'presentation/blocs/main/bottom_navigation_bar_cubit.dart';
import 'presentation/blocs/main/drag_route_cubit.dart';
import 'presentation/blocs/main/navigator_key_cubit.dart';
import 'presentation/blocs/main/second_navigation_bar_cubit.dart';
import 'locator.dart' as di;
import 'presentation/blocs/member/member_bloc.dart';
import 'presentation/blocs/pip/segment_toggle/segment_toggle_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runApp(MyApp(navigatorKey: navigatorKey));
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
          BlocProvider(create: (_) => di.sl<MemberBloc>()),
        ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.main,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
    
  }
}
