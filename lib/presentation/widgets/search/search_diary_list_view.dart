import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wazzang_diary/domain/entities/diary/diary_details.dart';

import '../../../core/enums/sort_type.dart';
import '../../../core/themes/theme.dart';
import '../../../domain/usecases/diary/fetch_diary_detail_use_case.dart';
import '../../blocs/diary/current_diary_bloc.dart';
import '../../blocs/main/drag_route_cubit.dart';
import '../../blocs/pip/segment_toggle/segment_toggle_cubit.dart';
import '../../blocs/search/search_diary_bloc.dart';

class SearchDiaryListView extends StatefulWidget {
  const SearchDiaryListView({super.key});

  @override
  State<SearchDiaryListView> createState() => _SearchDiaryListViewState();
}

class _SearchDiaryListViewState extends State<SearchDiaryListView> {
  SortType _sortType = SortType.latest;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SearchDiaryBloc>().add(FetchFirstDiaries(_sortType));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<SearchDiaryBloc>().add(FetchMoreDiaries(_sortType));
    }
  }

  bool get _isBottom {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalMargin = screenWidth * 0.025;
    double itemHeight = (screenWidth - horizontalMargin * 2) / 3;
    double contentPadding = 10;
    double contentWidth =
        screenWidth - horizontalMargin * 2 - itemHeight - contentPadding * 2;
    double filterBtnHeight = 40;
    double filterBtnMarin = 24;

    return BlocBuilder<SearchDiaryBloc, SearchDiaryState>(
        builder: (context, state) {
      final currentState = state;
      if (currentState is SearchDiaryLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (currentState is SearchDiaryLoaded) {
        final data = currentState.diaryDetails;
        final isLoadingMore = currentState.isLoadingMore;
        return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: data.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _filterBtnRow(
                    filterBtnMarin: filterBtnMarin,
                    filterBtnHeight: filterBtnHeight,
                    screenWidth: screenWidth);
              } else if (index == data.length + 1) {
                return isLoadingMore
                    ? const Center(child: CircularProgressIndicator())
                    : Container();
              } else {
                return itemWidget(
                    diaryDetail: data[index - 1],
                    height: itemHeight,
                    horizontalMargin: horizontalMargin,
                    contentPadding: contentPadding,
                    contentWidth: contentWidth);
              }
            });
      } else {
        return Container();
      }
    });
  }

  Widget itemWidget(
      {required double height,
      required double horizontalMargin,
      required double contentPadding,
      required double contentWidth,
      required DiaryDetails diaryDetail}) {
    return GestureDetector(
      onTap: () {
        context.read<DragRouteCubit>().handlePipTap();
        context
            .read<SegmentToggleCubit>()
            .update(<SegmentToggle>{SegmentToggle.image});
        context
            .read<CurrentDiaryBloc>()
            .add(FetchDiary(FetchDiaryDetailParams(diaryId: diaryDetail.id)));
      },
      child: Container(
        margin:
            EdgeInsets.fromLTRB(horizontalMargin, 0, horizontalMargin, 10),
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도
                spreadRadius: 1, // 그림자의 확산 정도
                blurRadius: 5, // 블러 효과의 반경
                offset: const Offset(0, 3), // 수평 및 수직 방향으로의 그림자 오프셋
              )
            ]),
        child: Row(
          children: [
            SizedBox(
              width: height,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  child: diaryDetail.imgUrl != null
                      ? Image.network(
                          diaryDetail.imgUrl!,
                          fit: BoxFit.cover,
                          height: height,
                        )
                      : Image.asset(
                          'assets/images/article_image_placeholder.jpg',
                          fit: BoxFit.cover,
                          height: height,
                        )),
            ),
            Padding(
              padding: EdgeInsets.all(contentPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: contentWidth,
                    child: Text(diaryDetail.title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  SizedBox(
                    width: contentWidth,
                    child: Text(diaryDetail.content,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _filterBtnRow(
      {required double filterBtnMarin,
      required double filterBtnHeight,
      required double screenWidth}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: filterBtnMarin / 2),
      height: filterBtnHeight,
      width: screenWidth,
      child: ListView.builder(
        itemCount: SortType.values.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox(width: 10);
          } else {
            return _filterBtnWidget(
                sort: SortType.values[index - 1], isActive: true);
          }
        },
      ),
    );
  }

  Widget _filterBtnWidget({required SortType sort, required bool isActive}) {
    Color backgroundColor = _sortType == sort ? darkblueColor : ivoryColor;
    Color fontColor = _sortType == sort ? Colors.white : Colors.black87;
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: OutlinedButton(
        onPressed: () {
          if (mounted) {
            setState(() {
              _sortType = sort;
            });
          }
          context.read<SearchDiaryBloc>().add(FetchFirstDiaries(sort));
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            side: MaterialStateProperty.resolveWith<BorderSide>(
                (states) => BorderSide.none),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => backgroundColor)),
        child: Text(
          sort.name,
          style: TextStyle(color: fontColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
