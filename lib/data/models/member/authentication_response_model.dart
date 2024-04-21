import 'package:freezed_annotation/freezed_annotation.dart';

import 'member_model.dart';

part 'authentication_response_model.freezed.dart';
part 'authentication_response_model.g.dart';

@freezed
class AuthenticationResponseModel with _$AuthenticationResponseModel {
  const factory AuthenticationResponseModel({
    required String token,
    required MemberModel memberModel,
  }) = _AuthenticationResponseModel;

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseModelFromJson(json);
}
