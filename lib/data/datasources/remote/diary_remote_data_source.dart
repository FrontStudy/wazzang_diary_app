import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wazzang_diary/domain/usecases/diary/add_bookmark_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/fetch_diary_list_use_case.dart';

import 'package:http/http.dart' as http;
import 'package:wazzang_diary/domain/usecases/diary/like_diary_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/remove_bookmark_use_case.dart';

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/usecases/diary/fetch_diary_detail_list_use_case.dart';
import '../../../domain/usecases/diary/unlike_diary_use_case.dart';
import '../../models/diary/diary_details_list_model.dart';
import '../../models/diary/diary_list_model.dart';
import '../../models/response_model.dart';

abstract class DiaryRemoteDataSource {
  Future<ResponseModel<DiaryListModel>> getPubDiaries(
      FetchPublicDiaryListParams params);

  Future<ResponseModel<DiaryDetailsListModel>> getPubDiaryDetails(
      FetchPublicDiaryDetailsListParams params, String token);

  Future<void> likeDiary(LikeDiaryParams params, String token);

  Future<void> unlikeDiary(UnlikeDiaryParams params, String token);

  Future<void> addBookmark(AddBookmarkParams params, String token);

  Future<void> removeBookmark(RemoveBookmarkParams params, String token);
}

class DiaryRemoteDataSourceImpl extends DiaryRemoteDataSource {
  final http.Client client;
  DiaryRemoteDataSourceImpl({required this.client});

  @override
  Future<ResponseModel<DiaryListModel>> getPubDiaries(
      FetchPublicDiaryListParams params) async {
    try {
      final response = await client.get(
          Uri.parse('$baseUrl/pub/diaryList').replace(queryParameters: {
            "offset": params.offset.toString(),
            "size": params.size.toString()
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseData['data'] == null
            ? ResponseModel.fromJsonWithoutData(responseData)
            : ResponseModel.fromJsonList(
                responseData, DiaryListModel.fromJsonList);
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ResponseModel<DiaryDetailsListModel>> getPubDiaryDetails(
      FetchPublicDiaryDetailsListParams params, String token) async {
    try {
      final response = await client.get(
          Uri.parse('$baseUrl/svc/pubDiaryDetailList').replace(
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
                responseData, DiaryDetailsListModel.fromJsonList);
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<void> likeDiary(LikeDiaryParams params, String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/svc/diary/${params.diaryId}/likes'),
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
  Future<void> unlikeDiary(UnlikeDiaryParams params, String token) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/svc/diary/${params.diaryId}/likes'),
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

  @override
  Future<void> addBookmark(AddBookmarkParams params, String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/svc/diary/${params.diaryId}/bookmark'),
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
  Future<void> removeBookmark(RemoveBookmarkParams params, String token) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/svc/diary/${params.diaryId}/bookmark'),
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
      debugPrint(response.statusCode.toString());
      throw AuthenticationFailure();
    } else {
      throw ServerException();
    }
  }
}
