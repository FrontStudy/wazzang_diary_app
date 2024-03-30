import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/main/bottom_navigation_bar_cubit.dart';
import 'presentation/bloc/main/drag_route_cubit.dart';
import 'presentation/bloc/main/navigator_key_cubit.dart';
import 'core/routes/sub_navigator_routes.dart';
import 'core/constants/constants.dart';
import 'presentation/widgets/main/first_bottom_navi_bar.dart';
import 'presentation/widgets/main/pip_page.dart';
import 'presentation/widgets/main/second_bottom_navi_bar.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DragRouteCubit>(create: (_) => DragRouteCubit()),
          BlocProvider<BottomNavigationBarCubit>(
              create: (_) => BottomNavigationBarCubit()),
          BlocProvider<NavigatorKeyCubit>(
              create: (_) => NavigatorKeyCubit(navigatorKey))
        ],
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _startAnimation(double start, double end, bool isFirstScale) {
    Duration duration =
        Duration(milliseconds: ((end - start).abs() * 100).round());
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: start, // 시작점
      end: end, // 종료점 (x축으로 1만큼 이동)
    ).animate(_controller!)
      ..addListener(() {
        if (isFirstScale) {
          context.read<DragRouteCubit>().updateFirstScale(_animation!.value);
        } else {
          context.read<DragRouteCubit>().updateSecondScale(_animation!.value);
        }
      });

    _controller!.forward();
  }

  double? _getPipNeedBottom(DragState dragState) {
    double? pipNeedBottom;
    if (dragState.pageIndex == 0) {
      pipNeedBottom = 0;
    } else if (dragState.pageIndex == 1) {
      if (dragState.firstScale == 1) {
        pipNeedBottom = null;
      } else {
        pipNeedBottom = 0;
      }
    } else {
      pipNeedBottom = null;
    }

    return pipNeedBottom;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: BlocConsumer<DragRouteCubit, DragState>(
          listener: (context, dragState) {
        if (dragState.shouldAnimate) {
          context.read<DragRouteCubit>().resetAnimationFlag();
          _startAnimation(
              dragState.isfirstScaleAnimated!
                  ? dragState.firstScale
                  : dragState.secondScale,
              dragState.animateTargetScale!,
              dragState.isfirstScaleAnimated!);
        }
      }, builder: (context, dragState) {
        double? pipNeedBottom = _getPipNeedBottom(dragState);

        return Stack(children: [
          Container(
              color: Colors.white,
              height: screenSize.height,
              child: Navigator(
                  key: context.read<NavigatorKeyCubit>().state,
                  onGenerateRoute: SubNavigatorRoutes.onGenerateRoutes)),
          Positioned(
              bottom: pipNeedBottom,
              child: GestureDetector(
                onTap: (() => context.read<DragRouteCubit>().handlePipTap()),
                onVerticalDragUpdate: ((details) {
                  if (dragState.pageIndex == 2) {
                    context
                        .read<DragRouteCubit>()
                        .handleSecondTabDragUpdate(details.primaryDelta!);
                  } else {
                    context
                        .read<DragRouteCubit>()
                        .handlePipDragUpdate(details.primaryDelta!);
                  }
                }),
                onVerticalDragEnd: ((details) {
                  if (dragState.pageIndex == 2) {
                    context.read<DragRouteCubit>().handleSecondTabDragEnd();
                  } else {
                    context.read<DragRouteCubit>().handlePipDragEnd();
                  }
                }),
                child: Container(
                    color: Colors.red,
                    padding:
                        EdgeInsets.only(top: paddingTop * dragState.firstScale),
                    height: pipHeight +
                        firstBottombarHeight +
                        (screenSize.height -
                                (pipHeight + firstBottombarHeight)) *
                            dragState.firstScale -
                        (screenSize.height - pipHeight - paddingTop) *
                            dragState.secondScale,
                    width: screenSize.width,
                    child: PipPage(
                        width: screenSize.width,
                        height: screenSize.height - paddingTop)),
              )),
          Positioned(
              bottom: 0,
              child: GestureDetector(
                onVerticalDragUpdate: ((details) {
                  if (dragState.pageIndex == 2) {
                    context
                        .read<DragRouteCubit>()
                        .handleSecondTabDragUpdate(details.primaryDelta!);
                  } else {
                    context
                        .read<DragRouteCubit>()
                        .handleSecondTabDragUpdate(details.primaryDelta!);
                  }
                }),
                onVerticalDragEnd: ((details) =>
                    context.read<DragRouteCubit>().handleSecondTabDragEnd()),
                child: Opacity(
                    opacity: dragState.firstScale,
                    child: SecondBottomNaviBar(
                        height: secondBottomBarHeight * dragState.firstScale +
                            (screenSize.height -
                                    secondBottomBarTopGap -
                                    secondBottomBarHeight *
                                        dragState.firstScale) *
                                dragState.secondScale)),
              )),
          Positioned(
              bottom: 0,
              child: Opacity(
                  opacity: 1 - dragState.firstScale,
                  child: FirstBottomNaviBar(
                      height:
                          firstBottombarHeight * (1 - dragState.firstScale))))
        ]);
      }),
    );
  }
}
