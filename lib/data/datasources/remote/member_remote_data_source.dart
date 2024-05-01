import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazzang_diary/domain/usecases/member/sign_in_usecase.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_up_usecase.dart';

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../models/member/authentication_response_model.dart';
import '../../models/member/member_model.dart';
import '../../models/response_model.dart';

abstract class MemberRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);

  Future<AuthenticationResponseModel> signUp(SignUpParams params);

  Future<ResponseModel<MemberModel>> getMemberByid(int i);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final http.Client client;
  MemberRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response = await client.post(Uri.parse('$baseUrl/pub/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': params.email,
          'passwd': params.passwd,
        }));

    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 &&
        responseData["status"] == "success") {
      return AuthenticationResponseModel.fromJson(responseData["data"]);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
    final response = await client.post(Uri.parse('$baseUrl/pub/members'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': params.email,
          'passwd': params.passwd,
          'nickname': params.nickname,
          'name': params.name,
          'gender': params.gender,
          'birthDate': params.birthDate,
          'profilePicture': params.profilePicture
        }));
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 &&
        responseData["status"] == "success") {
      return AuthenticationResponseModel.fromJson(responseData["data"]);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 409) {
      throw DuplicateFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ResponseModel<MemberModel>> getMemberByid(int i) async {
    final response =
        await client.get(Uri.parse('$baseUrl/pub/members/$i'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      if (responseData['data'] == null) {
        return ResponseModel.fromJsonWithoutData(responseData);
      } else {
        return ResponseModel.fromJsonMap(responseData, MemberModel.fromJson);
      }
    } else {
      throw ServerException();
    }
  }
}
