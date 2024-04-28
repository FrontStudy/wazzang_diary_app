import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import 'package:wazzang_diary/domain/entities/member/image/image.dart';

import 'package:wazzang_diary/domain/usecases/signup/set_profile_image_usecase.dart';

import '../../core/network/network_info.dart';
import '../../domain/repositories/image/image_repository.dart';
import '../datasources/local/member_local_data_source.dart';
import '../datasources/remote/image_remote_data_source.dart';

class ImageRepositoryImpl extends ImageRepository {
  final ImageRemoteDataSource remoteDataSource;
  final MemberLocalDataSource memberLocalDataSource;
  final NetworkInfo networkInfo;

  ImageRepositoryImpl(
      {required this.remoteDataSource,
      required this.memberLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Image>> uploadImageAndGetUrl(
      SetProfileImageParams params) async {
    if (!await networkInfo.isConnected) return Left(NetworkFailure());
    try {
      final imageListResponseModel = await remoteDataSource.uploadImage(params);
      return Right(imageListResponseModel.imageList.first);
    } catch (e) {
      return Left(ExceptionFailure());
    }
  }
}
