import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wazzang_diary/domain/usecases/diary/fetch_diary_list_use_case.dart';

import 'package:http/http.dart' as http;

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../models/diary/diary_list_model.dart';
import '../../models/response_model.dart';

abstract class DiaryRemoteDataSource {
  Future<ResponseModel<DiaryListModel>> getPubDiaries(
      FetchPublicDiaryListParams params);
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
}
