import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wazzang_diary/domain/usecases/comment/add_comment_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:wazzang_diary/domain/usecases/comment/fetch_comment_use_case.dart';

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../models/comment/comment_list_model.dart';
import '../../models/response_model.dart';

abstract class CommentRemoteDataSource {
  Future<void> addComment(AddCommentParams params, String token);

  Future<ResponseModel<CommentListModel>> fetchComment(
      FetchCommentParams params, String token);
}

class CommentRemoteDataSourceImpl extends CommentRemoteDataSource {
  final http.Client client;

  CommentRemoteDataSourceImpl({required this.client});

  @override
  Future<void> addComment(AddCommentParams params, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/svc/comment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json
            .encode({"diaryId": params.diaryId, "content": params.content}));

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      if (responseData['status'] == "success") {
        return;
      } else {
        throw ServerException();
      }
    } else if (response.statusCode == 403) {
      throw AuthenticationFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ResponseModel<CommentListModel>> fetchComment(
      FetchCommentParams params, String token) async {
    try {
      final response = await client.get(
          Uri.parse('$baseUrl/svc/diary/${params.diaryId}/comment').replace(
              queryParameters: {
                "offset": params.offset.toString(),
                "size": params.size.toString()
              }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseData['data'] == null
            ? ResponseModel.fromJsonWithoutData(responseData)
            : ResponseModel.fromJsonList(
                responseData, CommentListModel.fromJsonList);
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
