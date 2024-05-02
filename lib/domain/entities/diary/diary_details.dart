import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_details.freezed.dart';

@freezed
abstract class DiaryDetails with _$DiaryDetails {
  factory DiaryDetails(
      {required String createdDate,
      required String modifiedDate,
      required int id,
      required int memberId,
      required String title,
      required String content,
      String? imgUrl,
      required String accessLevel,
      required bool active,
      required int readCount,
      required int likeCount,
      required int commentCount,
      required bool isLiked,
      required bool isBookmarked,
      required int authorId,
      required String authorEmail,
      required String authorName,
      required String authorNickname,
      String? authorProfileUrl}) = _DiaryDetails;
}
