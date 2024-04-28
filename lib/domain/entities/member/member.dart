import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'member.freezed.dart';

@freezed
abstract class Member with _$Member {
  factory Member({
    required int id,
    required String email,
    required String name,
    required String nickname,
    String? birthDate,
    String? gender,
    int? profilePicture,
  }) = _Member;
}
