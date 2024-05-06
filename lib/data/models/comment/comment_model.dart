import '../../../domain/entities/comment/comment.dart';

class CommentModel {
  final Comment comment;

  CommentModel(
      {required String createdDate,
      required String modifiedDate,
      required int id,
      required int memberId,
      required String nickname,
      required int diaryId,
      required String content,
      required bool active})
      : comment = Comment(
            createdDate: createdDate,
            modifiedDate: modifiedDate,
            id: id,
            memberId: memberId,
            nickname: nickname,
            diaryId: diaryId,
            content: content,
            active: active);

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      createdDate: json['createdDate'] as String,
      modifiedDate: json['modifiedDate'] as String,
      id: json['id'] as int,
      memberId: json['memberId'] as int,
      nickname: json['nickname'] as String,
      diaryId: json['diaryId'] as int,
      content: json['content'] as String,
      active: json['active'] as bool);

  Map<String, dynamic> toJson() {
    return {
      'createdDate': comment.createdDate,
      'modifiedDate': comment.modifiedDate,
      'id': comment.id,
      'memberId': comment.memberId,
      'nickname': comment.nickname,
      'diaryId': comment.diaryId,
      'content': comment.content,
      'active': comment.active,
    };
  }
}
