import '../../../domain/entities/member/member.dart';

class MemberModel {
  final Member member;

  MemberModel({
    required int id,
    required String name,
    required String email,
    required String nickname,
    String? profilePicture,
    String? gender,
    String? birthDate,
  }) : member = Member(
            id: id,
            name: name,
            email: email,
            nickname: nickname,
            profilePicture: profilePicture,
            gender: gender,
            birthDate: birthDate);

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"] as int,
        name: json["name"] as String,
        email: json["email"] as String,
        nickname: json["nickname"] as String,
        profilePicture: json["profilePicture"] as String?,
        gender: json["gender"] as String?,
        birthDate: json["birthDate"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": member.id,
        "name": member.name,
        "email": member.email,
        "nickname": member.nickname,
        "profilePicture": member.profilePicture,
        "gender": member.gender,
        "birthDate": member.birthDate,
      };
}
