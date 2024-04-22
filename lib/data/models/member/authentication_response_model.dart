import 'member_model.dart';

class AuthenticationResponseModel {
  final String jtoken;
  final MemberModel memberModel;

  AuthenticationResponseModel({
    required this.jtoken,
    required int id,
    required String name,
    required String email,
    required String nickname,
    String? proflePicture,
    String? gender,
    String? birthDate,
  }) : memberModel =
            MemberModel(id: id, name: name, email: email, nickname: nickname);

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponseModel(
      jtoken: json["jtoken"] as String,
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
      nickname: json["nickname"] as String,
      proflePicture: json["profilePicture"] as String?,
      gender: json["gender"] as String?,
      birthDate: json["birthDate"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "jtoken": jtoken,
        "id": memberModel.member.id,
        "name": memberModel.member.name,
        "email": memberModel.member.email,
        "nickname": memberModel.member.nickname,
        "profilePicture": memberModel.member.profilePicture,
        "gender": memberModel.member.gender,
        "birthDate": memberModel.member.birthDate,
      };
}
