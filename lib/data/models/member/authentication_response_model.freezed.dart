// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthenticationResponseModel _$AuthenticationResponseModelFromJson(
    Map<String, dynamic> json) {
  return _AuthenticationResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationResponseModel {
  String get token => throw _privateConstructorUsedError;
  MemberModel get member => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticationResponseModelCopyWith<AuthenticationResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationResponseModelCopyWith<$Res> {
  factory $AuthenticationResponseModelCopyWith(
          AuthenticationResponseModel value,
          $Res Function(AuthenticationResponseModel) then) =
      _$AuthenticationResponseModelCopyWithImpl<$Res,
          AuthenticationResponseModel>;
  @useResult
  $Res call({String token, MemberModel member});

  $MemberModelCopyWith<$Res> get member;
}

/// @nodoc
class _$AuthenticationResponseModelCopyWithImpl<$Res,
        $Val extends AuthenticationResponseModel>
    implements $AuthenticationResponseModelCopyWith<$Res> {
  _$AuthenticationResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? member = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      member: null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MemberModelCopyWith<$Res> get member {
    return $MemberModelCopyWith<$Res>(_value.member, (value) {
      return _then(_value.copyWith(member: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenticationResponseModelImplCopyWith<$Res>
    implements $AuthenticationResponseModelCopyWith<$Res> {
  factory _$$AuthenticationResponseModelImplCopyWith(
          _$AuthenticationResponseModelImpl value,
          $Res Function(_$AuthenticationResponseModelImpl) then) =
      __$$AuthenticationResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, MemberModel member});

  @override
  $MemberModelCopyWith<$Res> get member;
}

/// @nodoc
class __$$AuthenticationResponseModelImplCopyWithImpl<$Res>
    extends _$AuthenticationResponseModelCopyWithImpl<$Res,
        _$AuthenticationResponseModelImpl>
    implements _$$AuthenticationResponseModelImplCopyWith<$Res> {
  __$$AuthenticationResponseModelImplCopyWithImpl(
      _$AuthenticationResponseModelImpl _value,
      $Res Function(_$AuthenticationResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? member = null,
  }) {
    return _then(_$AuthenticationResponseModelImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      member: null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as MemberModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationResponseModelImpl
    implements _AuthenticationResponseModel {
  const _$AuthenticationResponseModelImpl(
      {required this.token, required this.member});

  factory _$AuthenticationResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AuthenticationResponseModelImplFromJson(json);

  @override
  final String token;
  @override
  final MemberModel member;

  @override
  String toString() {
    return 'AuthenticationResponseModel(token: $token, member: $member)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationResponseModelImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.member, member) || other.member == member));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, member);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationResponseModelImplCopyWith<_$AuthenticationResponseModelImpl>
      get copyWith => __$$AuthenticationResponseModelImplCopyWithImpl<
          _$AuthenticationResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationResponseModelImplToJson(
      this,
    );
  }
}

abstract class _AuthenticationResponseModel
    implements AuthenticationResponseModel {
  const factory _AuthenticationResponseModel(
      {required final String token,
      required final MemberModel member}) = _$AuthenticationResponseModelImpl;

  factory _AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =
      _$AuthenticationResponseModelImpl.fromJson;

  @override
  String get token;
  @override
  MemberModel get member;
  @override
  @JsonKey(ignore: true)
  _$$AuthenticationResponseModelImplCopyWith<_$AuthenticationResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
