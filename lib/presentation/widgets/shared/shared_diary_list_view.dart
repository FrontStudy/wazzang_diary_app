import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/themes/theme.dart';
import '../../../core/utils/converter.dart';
import '../../../core/widgets/custom_button_with_shadow.dart';
import '../../../domain/entities/diary/diary_details.dart';
import '../../../domain/usecases/diary/fetch_diary_detail_use_case.dart';
import '../../../domain/usecases/diary/like_diary_use_case.dart';
import '../../../domain/usecases/diary/unlike_diary_use_case.dart';
import '../../blocs/main/drag_route_cubit.dart';
import '../../blocs/pip/segment_toggle/segment_toggle_cubit.dart';
import '../../blocs/shared_diary/shared_diary_bloc.dart';
import '../../blocs/diary/current_diary_bloc.dart' as current;

class SharedDiaryListView extends StatefulWidget {
  const SharedDiaryListView({super.key});

  @override
  State<SharedDiaryListView> createState() => _SharedDiaryListViewState();
}

class _SharedDiaryListViewState extends State<SharedDiaryListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SharedDiaryBloc>().add(FetchFirstDiaries());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<SharedDiaryBloc>().add(FetchMoreDiaries());
    }
  }

  bool get _isBottom {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }

  @override
  Widget build(BuildContext context) {
    const double listViewHorizontalMargin = 25;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: listViewHorizontalMargin),
      child: BlocBuilder<SharedDiaryBloc, SharedDiaryState>(
          builder: (context, state) {
        if (state is SharedDiaryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SharedDiaryLoaded) {
          final data = state.diaryDetails;
          final isLoadingMore = state.isLoadingMore;
          return ListView.builder(
            controller: _scrollController,
            itemCount: data.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _listTitleWidget();
              } else if (index == data.length + 1) {
                return isLoadingMore
                    ? const Center(child: CircularProgressIndicator())
                    : Container();
              } else {
                return _listItemWidget(
                    context: context,
                    diaryDetail: data[index - 1],
                    listViewHorizontalMargin: listViewHorizontalMargin);
              }
            },
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _listTitleWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "친구들의 마음 속 이야기",
            style: GoogleFonts.gamjaFlower(
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listItemWidget(
      {required BuildContext context,
      required DiaryDetails diaryDetail,
      required double listViewHorizontalMargin}) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double articleImageSize = 90;
    const double listItemPadding = 15;
    final double titleWidth = screenWidth -
        articleImageSize -
        listViewHorizontalMargin * 2 -
        listItemPadding * 2 -
        5;
    const double profileWidth = 20;
    const double profileGap = 5;
    final double nicknameWidth = titleWidth - profileWidth - profileGap - 5;

    return GestureDetector(
      onTap: () {
        context.read<DragRouteCubit>().handlePipTap();
        context
            .read<SegmentToggleCubit>()
            .update(<SegmentToggle>{SegmentToggle.image});
        context.read<current.CurrentDiaryBloc>().add(current.FetchDiary(
            FetchDiaryDetailParams(diaryId: diaryDetail.id)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(listItemPadding),
        decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[200]!, width: 0.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: articleImageSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Container(
                              width: profileWidth,
                              height: profileWidth,
                              color: Colors.blue,
                              child: Image.asset(
                                'assets/images/person_placeholder.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: profileGap),
                          SizedBox(
                              width: nicknameWidth,
                              child: Text(
                                diaryDetail.authorNickname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: titleWidth,
                        child: Text(diaryDetail.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: diaryDetail.imgUrl != null
                      ? Image.network(
                          diaryDetail.imgUrl!,
                          width: articleImageSize,
                          height: articleImageSize,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/article_image_placeholder.jpg',
                          width: articleImageSize,
                          height: articleImageSize,
                          fit: BoxFit.cover,
                        ),
                )
              ],
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    parseToTimeAgo(diaryDetail.createdDate),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  !diaryDetail.isLiked
                      ? CustomButtonWithShadow(
                          width: 90,
                          child: const Text("♡ Like"),
                          onPressed: () {
                            context.read<SharedDiaryBloc>().add(UnlikeDiary(
                                UnlikeDiaryParams(diaryId: diaryDetail.id)));
                          },
                        )
                      : SizedBox(
                          width: 90,
                          child: OutlinedButton(
                            onPressed: () {
                              context.read<SharedDiaryBloc>().add(LikeDiary(
                                  LikeDiaryParams(diaryId: diaryDetail.id)));
                            },
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: lightBlueColor, width: 2),
                                padding: EdgeInsets.zero),
                            child: const Text(
                              "♥︎ Liked",
                              style: TextStyle(color: lightBlueColor),
                            ),
                          ),
                        )
                ],
              ),
            ),
            Text(
              diaryDetail.content,
              maxLines: 3,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
