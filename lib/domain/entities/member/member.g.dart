// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'nickname': instance.nickname,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
    };
