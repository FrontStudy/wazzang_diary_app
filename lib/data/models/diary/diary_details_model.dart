import '../../../domain/entities/diary/diary_details.dart';

class DiaryDetailsModel {
  final DiaryDetails diaryDetails;

  DiaryDetailsModel(
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
      required bool isFollowing,
      required int authorFollowerCount,
      required int authorId,
      required String authorEmail,
      required String authorName,
      required String authorNickname,
      String? authorProfileUrl})
      : diaryDetails = DiaryDetails(
            createdDate: createdDate,
            modifiedDate: modifiedDate,
            id: id,
            memberId: memberId,
            title: title,
            content: content,
            imgUrl: imgUrl,
            accessLevel: accessLevel,
            active: active,
            readCount: readCount,
            likeCount: likeCount,
            commentCount: commentCount,
            isLiked: isLiked,
            isBookmarked: isBookmarked,
            isFollowing: isFollowing,
            authorFollowerCount: authorFollowerCount,
            authorId: authorId,
            authorEmail: authorEmail,
            authorName: authorName,
            authorNickname: authorNickname,
            authorProfileUrl: authorProfileUrl);

  factory DiaryDetailsModel.fromJson(Map<String, dynamic> json) =>
      DiaryDetailsModel(
          createdDate: json['createdDate'],
          modifiedDate: json['modifiedDate'],
          id: json['id'],
          memberId: json['memberId'],
          title: json['title'],
          content: json['content'],
          imgUrl: json['imgUrl'],
          accessLevel: json['accessLevel'],
          active: json['active'],
          readCount: json['readCount'],
          likeCount: json['likeCount'],
          commentCount: json['commentCount'],
          isLiked: json['isLiked'],
          isBookmarked: json['isBookmarked'],
          isFollowing: json['isFollowing'],
          authorFollowerCount: json['authorFollowerCount'],
          authorId: json['authorId'],
          authorEmail: json['authorEmail'],
          authorName: json['authorName'],
          authorNickname: json['authorNickname'],
          authorProfileUrl: json['authorProfileUrl']);
}
