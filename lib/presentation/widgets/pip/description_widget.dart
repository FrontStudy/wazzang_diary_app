import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazzang_diary/domain/entities/diary/diary_details.dart';

import '../../../core/themes/theme.dart';
import '../../../core/utils/converter.dart';
import '../../../domain/usecases/comment/fetch_comment_use_case.dart';
import '../../../domain/usecases/diary/add_bookmark_use_case.dart';
import '../../../domain/usecases/diary/like_diary_use_case.dart';
import '../../../domain/usecases/diary/remove_bookmark_use_case.dart';
import '../../../domain/usecases/diary/unlike_diary_use_case.dart';
import '../../../domain/usecases/follow/follow_use_case.dart';
import '../../../domain/usecases/follow/unfollow_use_case.dart';
import '../../blocs/comment/comment_bloc.dart';
import '../../blocs/diary/current_diary_bloc.dart';
import '../../blocs/main/drag_route_cubit.dart';
import '../../blocs/main/second_navigation_bar_cubit.dart';
import '../../blocs/member/member_bloc.dart';
import '../../blocs/pip/segment_toggle/segment_toggle_cubit.dart';

class DescriptionWidget extends StatelessWidget {
  final double top;
  final double leftPadding;
  final double height;
  const DescriptionWidget({
    super.key,
    required this.top,
    required this.leftPadding,
    required this.height,
    DiaryDetails? data,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      final dragState = context.select((DragRouteCubit cubit) => cubit.state);
      final toggleState =
          context.select((SegmentToggleCubit cubit) => cubit.state);
      final currentDiaryState =
          context.select((CurrentDiaryBloc bloc) => bloc.state);
      DiaryDetails? data;
      if (currentDiaryState is CurrentDiaryLoaded) {
        data = currentDiaryState.diaryDetails;
      }
      bool visible = toggleState.first == SegmentToggle.image &&
          (dragState.firstScale != 0 || dragState.secondScale != 1);
      double opacity = dragState.secondScale > 0
          ? 1 - dragState.secondScale
          : dragState.firstScale;

      return Positioned(
        top: top * (1 - dragState.secondScale),
        child: Visibility(
          visible: visible,
          maintainState: true,
          child: Opacity(
            opacity: opacity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: leftPadding),
              height: height,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 8),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            data?.title ?? ' ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 35,
                                width: 35,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: data?.authorProfileUrl != null
                                        ? Image.network(data!.authorProfileUrl!)
                                        : Image.asset(
                                            'assets/images/person_placeholder.png')),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                data?.authorNickname ?? '',
                                style: TextStyle(
                                    color: Colors.grey[100],
                                    fontSize: 16,
                                    height: 1.3),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                data?.authorFollowerCount != null
                                    ? parseToKorean(data!.authorFollowerCount)
                                    : ' ',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                    height: 0.8),
                              ),
                            ],
                          ),
                          data?.isFollowing == true
                              ? SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (data == null) return;
                                        context.read<CurrentDiaryBloc>().add(
                                            Unfollow(UnfollowParams(
                                                followedId: data.authorId)));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lightBlueColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                      ),
                                      child: const Text(
                                        '팔로잉',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              : SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (data == null) return;
                                        context.read<CurrentDiaryBloc>().add(
                                            Follow(FollowParams(
                                                followedId: data.authorId)));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ivoryColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                      ),
                                      child: const Text(
                                        '팔로우',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: darkblueColor,
                                        ),
                                      )),
                                )
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (data == null) return;
                                  if (data.isLiked == true) {
                                    context.read<CurrentDiaryBloc>().add(
                                        UnlikeDiary(UnlikeDiaryParams(
                                            diaryId: data.id)));
                                  } else {
                                    context.read<CurrentDiaryBloc>().add(
                                        LikeDiary(LikeDiaryParams(
                                            diaryId: data.id)));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightBlueColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 0.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      data?.isLiked == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      data?.likeCount != null
                                          ? parseToKorean(data!.likeCount)
                                          : ' ',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () {
                                  if (data == null) return;
                                  if (data.isBookmarked == true) {
                                    context.read<CurrentDiaryBloc>().add(
                                        RemoveBookmark(RemoveBookmarkParams(
                                            diaryId: data.authorId)));
                                  } else {
                                    context.read<CurrentDiaryBloc>().add(
                                        AddBookmark(AddBookmarkParams(
                                            diaryId: data.authorId)));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightBlueColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 0.0),
                                  // 원하는 여백 값을 EdgeInsets.symmetric을 사용하여 설정합니다.
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      data?.isBookmarked == true
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      '저장',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 90,
                    child: ElevatedButton(
                        onPressed: () {
                          if (data == null) return;
                          if (context
                                  .read<SecondNavigationBarCubit>()
                                  .controller!
                                  .index ==
                              1) {
                            context
                                .read<DragRouteCubit>()
                                .startSecondScaleAnimation(2);
                          } else {
                            final diaryState =
                                context.read<CurrentDiaryBloc>().state;
                            if (diaryState is CurrentDiaryLoaded) {
                              int diaryId = diaryState.diaryDetails.id;
                              context.read<CommentBloc>().add(FetchComment(
                                  FetchCommentParams(
                                      diaryId: diaryId, offset: 0, size: 10)));
                            }
                            context
                                .read<SecondNavigationBarCubit>()
                                .controller!
                                .animateTo(1);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          backgroundColor: lightBlueColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  '댓글',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      height: 0.8),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  data != null
                                      ? parseToKorean(data.commentCount)
                                      : ' ',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      height: 1.8),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                      width: 26,
                                      height: 26,
                                      color: Colors.blue,
                                      child:
                                          BlocBuilder<MemberBloc, MemberState>(
                                        builder: (context, state) => state
                                                    is MemberLogged &&
                                                state.member.profilePicture !=
                                                    null
                                            ? Image.network(
                                                state.member.profilePicture!,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/person_placeholder.png',
                                                fit: BoxFit.cover,
                                              ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ivoryColor,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    height: 26,
                                    width: screenWidth -
                                        2 * leftPadding -
                                        26 -
                                        20 -
                                        28,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
