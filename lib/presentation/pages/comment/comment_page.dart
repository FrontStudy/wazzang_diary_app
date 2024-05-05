import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/theme.dart';
import '../../../domain/usecases/comment/add_comment_use_case.dart';
import '../../blocs/comment/comment_bloc.dart';
import '../../blocs/diary/current_diary_bloc.dart';
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
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  bool _validate(String text) {
    return text.isNotEmpty;
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
          Positioned(
            left: 0,
            right: 0,
            bottom: isKeyboardVisible
                ? EdgeInsets.fromViewPadding(View.of(context).viewInsets,
                        View.of(context).devicePixelRatio)
                    .bottom
                : 0,
            child: Container(
              height: 50,
              width: screenWidth,
              margin: EdgeInsets.only(bottom: keyboardheight > 20 ? 0 : 30),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 1.0, color: Colors.grey))),
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
                            color: isKeyboardUp ? darkblueColor : Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
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
        ],
      ),
    );
  }
}
