import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
class MemberModel with _$MemberModel {
  const factory MemberModel({
    required String id,
    required String email,
    required String name,
    required String nickname,
    String? birthDate,
    String? gender,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}
