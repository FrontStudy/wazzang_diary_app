import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/member/image/image.dart';
import '../../repositories/image/image_repository.dart';

class SetProfileImageUseCase implements UseCase<Image, SetProfileImageParams> {
  final ImageRepository repository;
  SetProfileImageUseCase(this.repository);

  @override
  Future<Either<Failure, Image>> call(SetProfileImageParams params) async {
    return await repository.uploadImageAndGetUrl(params);
  }
}

class SetProfileImageParams {
  final XFile imageFile;
  SetProfileImageParams({required this.imageFile});
}
