import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wazzang_diary/domain/usecases/follow/follow_use_case.dart';
import 'package:wazzang_diary/domain/usecases/follow/unfollow_use_case.dart';

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';

abstract class FollowRemoteDataSource {
  Future<void> follow(FollowParams params, String token);

  Future<void> unfollow(UnfollowParams params, String token);
}

class FollowRemoteDataSourceImpl extends FollowRemoteDataSource {
  final http.Client client;
  FollowRemoteDataSourceImpl({required this.client});

  @override
  Future<void> follow(FollowParams params, String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/svc/member/${params.followedId}/follow'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      if (responseData['data'] == true) {
        return;
      } else {
        throw ServerException();
      }
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw AuthenticationFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> unfollow(UnfollowParams params, String token) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/svc/member/${params.followedId}/follow'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      if (responseData['data'] == false) {
        return;
      } else {
        throw ServerException();
      }
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw AuthenticationFailure();
    } else {
      throw ServerException();
    }
  }
}
