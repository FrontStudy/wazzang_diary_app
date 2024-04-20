import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/constants.dart';
import '../../core/themes/theme.dart';
import '../blocs/main/bottom_navigation_bar_cubit.dart';
import '../blocs/main/drag_route_cubit.dart';
import '../widgets/main/first_bottom_navi_bar.dart';
import '../widgets/main/second_bottom_navi_bar.dart';
import 'home/home_page.dart';
import 'pip/pip_page.dart';
import 'search/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const SearchPage(),
    const SearchPage()
  ];

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
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          context.read<DragRouteCubit>().setIsAnimating(true);
        }
        if (status == AnimationStatus.completed) {
          context.read<DragRouteCubit>().setIsAnimating(false);
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
      backgroundColor: Colors.grey[50],
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

        return SizedBox(
          height: screenSize.height,
          child: Stack(children: [
            BlocBuilder<BottomNavigationBarCubit, int>(
                builder: (context, state) {
              return SizedBox(
                  height: screenSize.height - firstBottombarHeight,
                  child: PageView(
                    controller:
                        context.read<BottomNavigationBarCubit>().controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _pages,
                  ));
            }),
            Positioned(
                bottom: pipNeedBottom,
                child: GestureDetector(
                  onTap: (() => context.read<DragRouteCubit>().handlePipTap()),
                  onVerticalDragUpdate: ((details) {
                    if (dragState.firstScale < 1 && dragState.firstScale >= 0) {
                      context
                          .read<DragRouteCubit>()
                          .handlePipDragUpdate(details.primaryDelta!);
                    } else if (dragState.firstScale == 1 &&
                        dragState.secondScale > 0) {
                      context
                          .read<DragRouteCubit>()
                          .handleSecondTabDragUpdate(details.primaryDelta!);
                    } else if (dragState.firstScale == 1 &&
                        dragState.secondScale == 0) {
                      if (details.primaryDelta! < 0) {
                        context
                            .read<DragRouteCubit>()
                            .handleSecondTabDragUpdate(details.primaryDelta!);
                      } else {
                        context
                            .read<DragRouteCubit>()
                            .handlePipDragUpdate(details.primaryDelta!);
                      }
                    } else {
                      context
                          .read<DragRouteCubit>()
                          .handlePipDragUpdate(details.primaryDelta!);
                    }
                  }),
                  onVerticalDragEnd: ((details) {
                    if (dragState.pageIndex == 2) {
                      context.read<DragRouteCubit>().handleSecondTabDragEnd();
                    } else if (dragState.pageIndex == 1) {
                      if (dragState.lastDragDelta < 0) {
                        context.read<DragRouteCubit>().handleSecondTabDragEnd();
                      } else {
                        context.read<DragRouteCubit>().handlePipDragEnd();
                      }
                    } else {
                      context.read<DragRouteCubit>().handlePipDragEnd();
                    }
                  }),
                  child: Container(
                      color: darkblueColor,
                      padding: EdgeInsets.only(
                          top: paddingTop * dragState.firstScale),
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
                top: screenSize.height -
                    ((secondBottomBarHeight - 2) * dragState.firstScale +
                        (screenSize.height -
                                pipHeight -
                                paddingTop -
                                secondBottomBarHeight) *
                            dragState.secondScale),
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
                          height: screenSize.height - pipHeight - paddingTop)),
                )),
            Positioned(
                bottom: 0,
                child: Opacity(
                    opacity: 1 - dragState.firstScale,
                    child: FirstBottomNaviBar(
                        height:
                            firstBottombarHeight * (1 - dragState.firstScale))))
          ]),
        );
      }),
    );
  }
}
