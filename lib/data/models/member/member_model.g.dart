// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberModelImpl _$$MemberModelImplFromJson(Map<String, dynamic> json) =>
    _$MemberModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$MemberModelImplToJson(_$MemberModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'nickname': instance.nickname,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
    };
