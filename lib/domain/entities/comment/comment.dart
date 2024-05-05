import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
abstract class Comment with _$Comment {
  factory Comment({
    required String createdDate,
    required String modifiedDate,
    required int id,
    required int memberId,
    required String nickname,
    String? profilePicture,
    required int diaryId,
    required String content,
    required bool active,
  }) = _Comment;
}
