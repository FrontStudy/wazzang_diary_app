import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/diary/diary_details.dart';
import '../../../domain/usecases/comment/fetch_comment_use_case.dart';
import '../../../domain/usecases/diary/add_bookmark_use_case.dart';
import '../../../domain/usecases/diary/fetch_diary_detail_use_case.dart';
import '../../../domain/usecases/diary/like_diary_use_case.dart';
import '../../../domain/usecases/diary/remove_bookmark_use_case.dart';
import '../../../domain/usecases/diary/unlike_diary_use_case.dart';
import '../../../domain/usecases/follow/follow_use_case.dart';
import '../../../domain/usecases/follow/unfollow_use_case.dart';
import '../../blocs/comment/comment_bloc.dart';
import '../../blocs/diary/pub_diary_bloc.dart';
import '../../blocs/diary/current_diary_bloc.dart' as current;
import '../../blocs/main/drag_route_cubit.dart';
import '../../blocs/main/second_navigation_bar_cubit.dart';
import '../../blocs/pip/segment_toggle/segment_toggle_cubit.dart';
import '../../pages/common/gradient_widget.dart';

class HomeDiaryListView extends StatefulWidget {
  const HomeDiaryListView({super.key});

  @override
  State<HomeDiaryListView> createState() => _HomeDiaryListViewState();
}

class _HomeDiaryListViewState extends State<HomeDiaryListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PubDiaryBloc>().add(FetchMoreDiaries());
    }
  }

  bool get _isBottom {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }

  String formatTimeAgo(String dateString) {
    DateTime now = DateTime.now();
    DateTime date = DateTime.parse(dateString);
    Duration difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds}초 전";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}분 전";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}시간 전";
    } else if (difference.inDays < 30) {
      return "${difference.inDays}일 전";
    } else if (difference.inDays < 365) {
      int months = difference.inDays ~/ 30;
      return "$months달 전";
    } else {
      int years = difference.inDays ~/ 365;
      return "$years년 전";
    }
  }

  void _openCommentPage({required BuildContext context, DiaryDetails? data}) {
    if (data == null) return;
    if (context.read<SecondNavigationBarCubit>().controller!.index == 1) {
      context.read<DragRouteCubit>().startSecondScaleAnimation(2);
    } else {
      final diaryState = context.read<current.CurrentDiaryBloc>().state;
      if (diaryState is current.CurrentDiaryLoaded) {
        int diaryId = diaryState.diaryDetails.id;
        context.read<CommentBloc>().add(FetchComment(
            FetchCommentParams(diaryId: diaryId, offset: 0, size: 10)));
      }
      context.read<SecondNavigationBarCubit>().controller!.animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<PubDiaryBloc, PubDiaryState>(builder: (context, state) {
      if (state is PubDiaryLoaded) {
        List<DiaryDetails> data = [];
        data = state.diaryDetails;

        return ListView.builder(
          controller: _scrollController,
          itemCount: state.isLoadingMore ? data.length + 1 : data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == data.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _diaryItemWidget(
                context: context,
                screenWidth: screenWidth,
                diaryDetails: data[index]);
          },
        );
      } else {
        return Container();
      }
    });
  }

  Widget _diaryItemWidget(
      {required BuildContext context,
      required double screenWidth,
      required DiaryDetails diaryDetails}) {
    return GestureDetector(
      onTap: () {
        context.read<DragRouteCubit>().handlePipTap();
        context
            .read<SegmentToggleCubit>()
            .update(<SegmentToggle>{SegmentToggle.image});
        context.read<current.CurrentDiaryBloc>().add(current.FetchDiary(
            FetchDiaryDetailParams(diaryId: diaryDetails.id)));
      },
      child: SizedBox(
        width: screenWidth,
        height: screenWidth + 110,
        child: Column(
          children: [
            Stack(
              children: [
                diaryDetails.imgUrl != null
                    ? Image.network(
                        diaryDetails.imgUrl!,
                        fit: BoxFit.cover,
                        height: screenWidth,
                        width: screenWidth,
                      )
                    : Image.asset(
                        'assets/images/article_image_placeholder.jpg',
                        fit: BoxFit.cover,
                        height: screenWidth,
                        width: screenWidth,
                      ),
                GradientMaskWidget(
                  isUpward: true,
                  child: SizedBox(
                    width: screenWidth,
                    child: Container(
                        color: const Color.fromARGB(1, 0, 0, 0), height: 80),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: GradientMaskWidget(
                    isUpward: false,
                    child: SizedBox(
                      width: screenWidth,
                      child: Container(
                          color: const Color.fromARGB(1, 0, 0, 0), height: 130),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    height: 80,
                    width: screenWidth,
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        diaryDetails.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromARGB(225, 255, 255, 255),
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: diaryDetails.authorProfileUrl != null
                                    ? Image.network(
                                        diaryDetails.authorProfileUrl!)
                                    : Image.asset(
                                        'assets/images/person_placeholder.png')),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              SizedBox(
                                height: 18,
                                child: Text(
                                  diaryDetails.authorNickname,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('회원님을 위한 추천',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 28,
                        width: 60,
                        child: OutlinedButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              side: MaterialStateProperty.all(
                                  const BorderSide(color: Colors.white70)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                            onPressed: () {
                              context.read<PubDiaryBloc>().add(
                                  diaryDetails.isFollowing
                                      ? Unfollow(UnfollowParams(
                                          followedId: diaryDetails.authorId))
                                      : Follow(FollowParams(
                                          followedId: diaryDetails.authorId)));
                            },
                            child: Text(
                              diaryDetails.isFollowing ? '팔로잉' : '팔로우',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12, height: 1),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 110,
              width: screenWidth,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                height: 30,
                                width: 30,
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<PubDiaryBloc>().add(
                                        diaryDetails.isLiked
                                            ? UnlikeDiary(UnlikeDiaryParams(
                                                diaryId: diaryDetails.id))
                                            : LikeDiary(LikeDiaryParams(
                                                diaryId: diaryDetails.id)));
                                  },
                                  child: diaryDetails.isLiked
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(Icons.favorite_border),
                                )),
                            Container(
                                margin: const EdgeInsets.all(5),
                                height: 30,
                                width: 30,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<DragRouteCubit>()
                                        .handlePipTap();
                                    context.read<SegmentToggleCubit>().update(
                                        <SegmentToggle>{SegmentToggle.image});
                                    context
                                        .read<current.CurrentDiaryBloc>()
                                        .add(current.FetchDiary(
                                            FetchDiaryDetailParams(
                                                diaryId: diaryDetails.id)));
                                    Future.delayed(
                                        const Duration(milliseconds: 400),
                                        () => _openCommentPage(
                                            context: context,
                                            data: diaryDetails));
                                  },
                                  child: const Icon(Icons.textsms_outlined),
                                )),
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                            height: 30,
                            width: 30,
                            child: GestureDetector(
                              onTap: () {
                                context.read<PubDiaryBloc>().add(
                                    !diaryDetails.isBookmarked
                                        ? AddBookmark(AddBookmarkParams(
                                            diaryId: diaryDetails.id))
                                        : RemoveBookmark(RemoveBookmarkParams(
                                            diaryId: diaryDetails.id)));
                              },
                              child: diaryDetails.isBookmarked
                                  ? const Icon(Icons.bookmark)
                                  : const Icon(Icons.bookmark_outline),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: FittedBox(
                              child: Text(
                            '좋아요 ${diaryDetails.likeCount}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 18,
                              child: FittedBox(
                                child: Text(diaryDetails.authorNickname,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              height: 18,
                              child: FittedBox(
                                child: Text(
                                  formatTimeAgo(diaryDetails.createdDate),
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        GestureDetector(
                          onTap: () {
                            context.read<DragRouteCubit>().handlePipTap();
                            context
                                .read<SegmentToggleCubit>()
                                .update(<SegmentToggle>{SegmentToggle.image});
                            context.read<current.CurrentDiaryBloc>().add(
                                current.FetchDiary(FetchDiaryDetailParams(
                                    diaryId: diaryDetails.id)));
                            Future.delayed(
                                const Duration(milliseconds: 400),
                                () => _openCommentPage(
                                    context: context, data: diaryDetails));
                          },
                          child: SizedBox(
                              height: 20,
                              child: Text(
                                '댓글 ${diaryDetails.commentCount}개 모두 보기',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 13.0),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
