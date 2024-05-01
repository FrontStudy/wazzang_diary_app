import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary.freezed.dart';

@freezed
abstract class Diary with _$Diary {
  factory Diary(
      {required int id,
      required int memberId,
      required String title,
      required String content,
      String? imgUrl,
      required String accessLevel,
      required bool active,
      required int readCount}) = _Diary;
}
