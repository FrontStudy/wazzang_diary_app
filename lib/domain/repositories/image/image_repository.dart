import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../entities/member/image/image.dart';
import '../../usecases/signup/set_profile_image_usecase.dart';

abstract class ImageRepository {
  Future<Either<Failure, Image>> uploadImageAndGetUrl(
      SetProfileImageParams params);
}
