import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/usecases/comment/fetch_comment_use_case.dart';
import '../../blocs/comment/comment_bloc.dart';
import '../../blocs/diary/current_diary_bloc.dart';
import '../../blocs/main/drag_route_cubit.dart';
import '../../blocs/main/second_navigation_bar_cubit.dart';
import '../../pages/comment/comment_page.dart';

class SecondBottomNaviBar extends StatefulWidget {
  final double height;

  const SecondBottomNaviBar({required this.height, super.key});

  @override
  State<SecondBottomNaviBar> createState() => _SecondBottomNaviBarState();
}

class _SecondBottomNaviBarState extends State<SecondBottomNaviBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (context.read<DragRouteCubit>().state.secondScale == 0) {
        context.read<DragRouteCubit>().startSecondScaleAnimation(2);
      }
      // if (_tabController.index == 0) {
      // } else if (_tabController.index == 1) {
      //   _commentPageInit();
      // } else {}
    });
    context.read<SecondNavigationBarCubit>().initController(_tabController);
  }

  // void _commentPageInit() {
  //   final diaryState = context.read<CurrentDiaryBloc>().state;
  //   final commentState = context.read<CommentBloc>().state;
  //   if (diaryState is CurrentDiaryLoaded && commentState is CommentInitial) {
  //     int diaryId = diaryState.diaryDetails.id;
  //     context.read<CommentBloc>().add(FetchComment(
  //         FetchCommentParams(diaryId: diaryId, offset: 0, size: 20)));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var dragState = context.select((DragRouteCubit cubit) => cubit.state);

    var paddingTop = MediaQuery.of(context).padding.top;
    var screenSize = MediaQuery.of(context).size;
    double dragHandleHeight = 4;
    double dragHandleVerticalMargin = 4;
    double tabBarTopGap = dragHandleHeight + dragHandleVerticalMargin * 2;
    double tabBarFirstHeight =
        secondBottomBarHeight - tabBarTopGap - 2 - 20 * dragState.secondScale;

    return ColoredBox(
      color: darkblueColor,
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            color: lightYellowColor,
          ),
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: OverflowBox(
            maxHeight: 900,
            maxWidth: screenSize.width,
            minHeight: 0,
            minWidth: 0,
            child: SizedBox(
              height: screenSize.height - pipHeight - paddingTop,
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: secondBottomBarHeight - 20 * dragState.secondScale,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: dragHandleVerticalMargin),
                          width: 40,
                          height: dragHandleHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ivoryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TabBar(
                            controller: _tabController,
                            dividerColor: darkblueColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: lightBlueColor,
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              Tab(
                                height: tabBarFirstHeight,
                                text: '다음 일기',
                              ),
                              Tab(
                                height: tabBarFirstHeight,
                                text: '댓글',
                              ),
                              Tab(
                                height: tabBarFirstHeight,
                                text: '관련 항목',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.height -
                        secondBottomBarHeight +
                        20 * dragState.secondScale,
                    width: screenSize.width,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller:
                          context.read<SecondNavigationBarCubit>().controller,
                      children: [
                        Container(
                          child: const Center(child: Text('First')),
                        ),
                        CommentPage(
                            height: widget.height -
                                secondBottomBarHeight +
                                20 * dragState.secondScale),
                        Container(
                          child: const Center(child: Text('Third')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
