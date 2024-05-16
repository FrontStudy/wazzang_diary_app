import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/theme.dart';
import '../../../domain/entities/comment/comment.dart';
import '../../../domain/usecases/comment/add_comment_use_case.dart';
import '../../../domain/usecases/comment/fetch_comment_use_case.dart';
import '../../blocs/comment/comment_bloc.dart';
import '../../blocs/diary/current_diary_bloc.dart';
import '../../blocs/main/drag_route_cubit.dart';
import '../../blocs/member/member_bloc.dart';

class CommentPage extends StatefulWidget {
  final double height;
  const CommentPage({
    required this.height,
    super.key,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late TextEditingController _textController;
  late ScrollController _scrollController;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool _validate(String text) {
    return text.isNotEmpty;
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CommentBloc>().add(FetchMoreComment());
    }
  }

  bool get _isBottom {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }

  @override
  Widget build(BuildContext context) {
    double keyboardheight = EdgeInsets.fromViewPadding(
            View.of(context).viewInsets, View.of(context).devicePixelRatio)
        .bottom;
    bool isKeyboardVisible = keyboardheight > 0;
    bool isKeyboardUp = keyboardheight > 20;

    double screenWidth = MediaQuery.of(context).size.width;
    double profileImgWidth = 26;
    double profileImgHorizontalPadding = 12;
    double commentSubmitBtnWidth = 55;

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          BlocListener<DragRouteCubit, DragState>(listenWhen:
              (previous, current) {
            return current.pageIndex == 2 &&
                previous.pageIndex != current.pageIndex;
          }, listener: (context, state) {
            final diaryState = context.read<CurrentDiaryBloc>().state;
            final commentState = context.read<CommentBloc>().state;
            if (diaryState is CurrentDiaryLoaded) {
              if (commentState is CommentLoaded &&
                  commentState.comments.isNotEmpty &&
                  commentState.comments[0].diaryId !=
                      diaryState.diaryDetails.id) {
                // 기존의 currentDiary와 댓글의 다이어리 번호가 다를 경우 댓글 새로고침
                context.read<CommentBloc>().add(FetchComment(FetchCommentParams(
                    diaryId: diaryState.diaryDetails.id, offset: 0, size: 10)));
              } else if (commentState is! CommentLoaded) {
                // 초기 댓글 목록 데이터 패치
                context.read<CommentBloc>().add(FetchComment(FetchCommentParams(
                    diaryId: diaryState.diaryDetails.id, offset: 0, size: 10)));
              }
            }
          }, child:
              BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
            List<Comment> data = [];
            if (state is CommentLoaded) {
              data = state.comments;
            }
            return SizedBox(
              height: widget.height,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          width: 70,
                          child: Center(
                            child: ClipOval(
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.blue,
                                  child: BlocBuilder<MemberBloc, MemberState>(
                                    builder: (context, state) => state
                                                is MemberLogged &&
                                            data[index].profilePicture != null
                                        ? Image.network(
                                            data[index].profilePicture!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/person_placeholder.png',
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index].nickname,
                              style: const TextStyle(color: lightBlueColor),
                            ),
                            SizedBox(
                              width: screenWidth - 100,
                              child: Text(
                                data[index].content,
                                maxLines: 5,
                                style: const TextStyle(color: darkblueColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          })),
          Positioned(
            left: 0,
            right: 0,
            bottom: isKeyboardVisible
                ? EdgeInsets.fromViewPadding(View.of(context).viewInsets,
                        View.of(context).devicePixelRatio)
                    .bottom
                : 0,
            child: Container(
              color: lightYellowColor,
              child: Container(
                height: 50,
                width: screenWidth,
                margin: EdgeInsets.only(bottom: keyboardheight > 20 ? 0 : 30),
                decoration: const BoxDecoration(
                    color: lightYellowColor,
                    border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ClipOval(
                        child: Container(
                            width: 26,
                            height: 26,
                            color: Colors.blue,
                            child: BlocBuilder<MemberBloc, MemberState>(
                              builder: (context, state) =>
                                  state is MemberLogged &&
                                          state.member.profilePicture != null
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
                    ),
                    Container(
                      height: 35,
                      width: isKeyboardUp
                          ? screenWidth -
                              profileImgHorizontalPadding * 2 -
                              profileImgWidth -
                              commentSubmitBtnWidth
                          : screenWidth -
                              profileImgHorizontalPadding * 2 -
                              profileImgWidth -
                              10,
                      padding: const EdgeInsets.only(left: 10, top: 14),
                      decoration: BoxDecoration(
                          color: keyboardheight > 20 ? null : lightBlueColor,
                          border: keyboardheight > 20
                              ? Border.all(color: darkblueColor)
                              : null,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        cursorHeight: 20,
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: '댓글 추가...',
                          hintStyle: TextStyle(
                              color:
                                  isKeyboardUp ? darkblueColor : Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                    if (isKeyboardUp)
                      SizedBox(
                        width: commentSubmitBtnWidth,
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (!_validate(_textController.text)) return;
                            final diaryState =
                                context.read<CurrentDiaryBloc>().state;
                            if (diaryState is CurrentDiaryLoaded) {
                              context.read<CommentBloc>().add(AddComment(
                                  AddCommentParams(
                                      content: _textController.text,
                                      diaryId: diaryState.diaryDetails.id)));
                            }
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
