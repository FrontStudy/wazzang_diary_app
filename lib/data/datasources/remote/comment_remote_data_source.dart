import 'dart:convert';

import 'package:wazzang_diary/domain/usecases/comment/add_comment_use_case.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';

abstract class CommentRemoteDataSource {
  Future<void> addComment(AddCommentParams params, String token);
}

class CommentRemoteDataSourceImpl extends CommentRemoteDataSource {
  final http.Client client;

  CommentRemoteDataSourceImpl({required this.client});

  @override
  addComment(AddCommentParams params, String token) async {
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
}
