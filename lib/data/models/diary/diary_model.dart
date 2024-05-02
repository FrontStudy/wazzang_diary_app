import '../../../domain/entities/diary/diary.dart';

class DiaryModel {
  final Diary diary;

  DiaryModel({
    required int id,
    required int memberId,
    required String title,
    required String content,
    String? imgUrl,
    required String accessLevel,
    required bool active,
    required int readCount,
  }) : diary = Diary(
            id: id,
            memberId: memberId,
            title: title,
            content: content,
            imgUrl: imgUrl,
            accessLevel: accessLevel,
            active: active,
            readCount: readCount);

  factory DiaryModel.fromJson(Map<String, dynamic> json) => DiaryModel(
        id: json['id'] as int,
        memberId: json['memberId'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        imgUrl: json['imgUrl'] as String?,
        accessLevel: json['accessLevel'] as String,
        active: json['active'] as bool,
        readCount: json['readCount'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': diary.id,
        'memberId': diary.memberId,
        'title': diary.title,
        'content': diary.content,
        'imgUrl': diary.imgUrl,
        'accessLevel': diary.accessLevel,
        'active': diary.active,
        'readCount': diary.readCount,
      };
}
