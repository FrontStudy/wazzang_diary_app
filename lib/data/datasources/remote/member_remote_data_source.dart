import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazzang_diary/domain/usecases/member/sign_in_usecase.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_up_usecase.dart';

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../models/member/authentication_response_model.dart';

abstract class MemberRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);

  Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final http.Client client;
  MemberRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response = await client.get(
        Uri.parse('$baseUrl/pub/login').replace(queryParameters: {
          'email': params.email,
          'passwd': params.passwd,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    final responseData = json.decode(response.body);
    if (response.statusCode == 200 &&
        json.decode(response.body)["status"] == "success") {
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
        }));
    final responseData = json.decode(response.body);
    if (response.statusCode == 200 &&
        json.decode(response.body)["status"] == "success") {
      return AuthenticationResponseModel.fromJson(responseData["data"]);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }
}
