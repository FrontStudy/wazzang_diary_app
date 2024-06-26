import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'member_detail_info.freezed.dart';

@freezed
class MemberDetailInfo with _$MemberDetailInfo {
  factory MemberDetailInfo(
      {required int id,
      required String email,
      required String name,
      required String nickname,
      String? birthDate,
      String? gender,
      String? profilePicture,
      required int diaryCount,
      required int followerCount,
      required int followingCount}) = _MemberDetailInfo;
}
