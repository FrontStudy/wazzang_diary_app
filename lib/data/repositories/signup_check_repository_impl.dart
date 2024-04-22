import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import 'package:wazzang_diary/core/usecases/usecase.dart';

import 'package:wazzang_diary/domain/usecases/signup/check_email_usecase.dart';

import '../../core/network/network_info.dart';
import '../../domain/repositories/signup/signup_check_repository.dart';
import '../datasources/remote/signup_check_remote_data_source.dart';

class SignUpCheckRepositoryImpl implements SignUpCheckRepository {
  final SignUpCheckRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SignUpCheckRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, NoParams>> checkEmail(CheckEmailParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final isDuplicate = await remoteDataSource.checkEmail(params);
        return !isDuplicate ? Right(NoParams()) : Left(DuplicateFailure());
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
