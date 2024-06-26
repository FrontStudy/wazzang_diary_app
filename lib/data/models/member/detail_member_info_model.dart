import '../../../domain/entities/member/member_detail_info.dart';

class MemberDetailInfoModel {
  final MemberDetailInfo memberDetailInfo;

  MemberDetailInfoModel(
      {required int id,
      required String name,
      required String email,
      required String nickname,
      String? profilePicture,
      String? gender,
      String? birthDate,
      required int diaryCount,
      required int followerCount,
      required int followingCount})
      : memberDetailInfo = MemberDetailInfo(
            id: id,
            name: name,
            email: email,
            nickname: nickname,
            profilePicture: profilePicture,
            gender: gender,
            birthDate: birthDate,
            diaryCount: diaryCount,
            followerCount: followerCount,
            followingCount: followingCount);

  factory MemberDetailInfoModel.fromJson(Map<String, dynamic> json) {
    return MemberDetailInfoModel(
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
      nickname: json["nickname"] as String,
      profilePicture: json["profilePicture"] as String?,
      gender: json["gender"] as String?,
      birthDate: json["birthDate"] as String?,
      diaryCount: json["diaryCount"] as int,
      followerCount: json["followerCount"] as int,
      followingCount: json["followingCount"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": memberDetailInfo.id,
      "name": memberDetailInfo.name,
      "email": memberDetailInfo.email,
      "nickname": memberDetailInfo.nickname,
      "profilePicture": memberDetailInfo.profilePicture,
      "gender": memberDetailInfo.gender,
      "birthDate": memberDetailInfo.birthDate,
      "diaryCount": memberDetailInfo.diaryCount,
      "followerCount": memberDetailInfo.followerCount,
      "followingCount": memberDetailInfo.followingCount,
    };
  }
}
