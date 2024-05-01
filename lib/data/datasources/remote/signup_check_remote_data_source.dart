import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../domain/usecases/signup/check_email_usecase.dart';

abstract class SignUpCheckRemoteDataSource {
  Future<bool> checkEmail(CheckEmailParams params);
}

class SignUpCheckRemoteDataSourceImpl implements SignUpCheckRemoteDataSource {
  final http.Client client;

  SignUpCheckRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> checkEmail(CheckEmailParams params) async {
    final response = await client.get(
        Uri.parse('$baseUrl/pub/check-email')
            .replace(queryParameters: {'email': params.email}),
        headers: {
          'Content-Type': 'application/json',
        });

    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 &&
        responseData["status"] == "success") {
      return responseData["data"];
    } else {
      throw ServerException();
    }
  }
}
