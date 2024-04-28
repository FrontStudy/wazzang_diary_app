import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:wazzang_diary/domain/usecases/signup/set_profile_image_usecase.dart';

import '../../../core/constants/strings.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../models/image/image_list_response_model.dart';

abstract class ImageRemoteDataSource {
  Future<ImageListResponseModel> uploadImage(SetProfileImageParams params);
}

class ImageRemoteDataSourceImpl extends ImageRemoteDataSource {
  final http.Client client;
  ImageRemoteDataSourceImpl({required this.client});

  @override
  Future<ImageListResponseModel> uploadImage(
      SetProfileImageParams params) async {
    final extension = path.extension(params.imageFile.path);

    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/pub/upImages'));
    request.files.add(
      await http.MultipartFile.fromPath('imgs', params.imageFile.path,
          filename: "${const Uuid().v4()}.$extension"),
    );

    var response = await client.send(request);
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);
      if (jsonData.containsKey("data")) {
        List<dynamic> val = jsonData["data"];
        return ImageListResponseModel.fromJson(val);
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
