// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) {
  return _MemberModel.fromJson(json);
}

/// @nodoc
mixin _$MemberModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get birthDate => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemberModelCopyWith<MemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberModelCopyWith<$Res> {
  factory $MemberModelCopyWith(
          MemberModel value, $Res Function(MemberModel) then) =
      _$MemberModelCopyWithImpl<$Res, MemberModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String nickname,
      String? birthDate,
      String? gender});
}

/// @nodoc
class _$MemberModelCopyWithImpl<$Res, $Val extends MemberModel>
    implements $MemberModelCopyWith<$Res> {
  _$MemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? nickname = null,
    Object? birthDate = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberModelImplCopyWith<$Res>
    implements $MemberModelCopyWith<$Res> {
  factory _$$MemberModelImplCopyWith(
          _$MemberModelImpl value, $Res Function(_$MemberModelImpl) then) =
      __$$MemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String nickname,
      String? birthDate,
      String? gender});
}

/// @nodoc
class __$$MemberModelImplCopyWithImpl<$Res>
    extends _$MemberModelCopyWithImpl<$Res, _$MemberModelImpl>
    implements _$$MemberModelImplCopyWith<$Res> {
  __$$MemberModelImplCopyWithImpl(
      _$MemberModelImpl _value, $Res Function(_$MemberModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? nickname = null,
    Object? birthDate = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$MemberModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberModelImpl implements _MemberModel {
  const _$MemberModelImpl(
      {required this.id,
      required this.email,
      required this.name,
      required this.nickname,
      this.birthDate,
      this.gender});

  factory _$MemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String nickname;
  @override
  final String? birthDate;
  @override
  final String? gender;

  @override
  String toString() {
    return 'MemberModel(id: $id, email: $email, name: $name, nickname: $nickname, birthDate: $birthDate, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, email, name, nickname, birthDate, gender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberModelImplCopyWith<_$MemberModelImpl> get copyWith =>
      __$$MemberModelImplCopyWithImpl<_$MemberModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberModelImplToJson(
      this,
    );
  }
}

abstract class _MemberModel implements MemberModel {
  const factory _MemberModel(
      {required final String id,
      required final String email,
      required final String name,
      required final String nickname,
      final String? birthDate,
      final String? gender}) = _$MemberModelImpl;

  factory _MemberModel.fromJson(Map<String, dynamic> json) =
      _$MemberModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get name;
  @override
  String get nickname;
  @override
  String? get birthDate;
  @override
  String? get gender;
  @override
  @JsonKey(ignore: true)
  _$$MemberModelImplCopyWith<_$MemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
