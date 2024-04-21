// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationResponseModelImpl _$$AuthenticationResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationResponseModelImpl(
      token: json['token'] as String,
      memberModel:
          MemberModel.fromJson(json['memberModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthenticationResponseModelImplToJson(
        _$AuthenticationResponseModelImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'memberModel': instance.memberModel,
    };
