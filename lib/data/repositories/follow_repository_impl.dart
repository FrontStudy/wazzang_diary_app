import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import 'package:wazzang_diary/core/usecases/usecase.dart';

import 'package:wazzang_diary/domain/usecases/follow/follow_use_case.dart';

import 'package:wazzang_diary/domain/usecases/follow/unfollow_use_case.dart';

import '../../core/network/network_info.dart';
import '../../domain/repositories/follow/follow_repository.dart';
import '../datasources/local/member_local_data_source.dart';
import '../datasources/remote/follow_remote_data_source.dart';

class FollowRepositoryImpl extends FollowRepository {
  final FollowRemoteDataSource remoteDataSource;
  final MemberLocalDataSource memberLocalDataSource;
  final NetworkInfo networkInfo;

  FollowRepositoryImpl(
      {required this.remoteDataSource,
      required this.memberLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NoParams>> follow(FollowParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          await remoteDataSource.follow(params, token);
          return Right(NoParams());
        } on Failure catch (failure) {
          return Left(failure);
        }
      } else {
        return Left(TokenFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> unfollow(UnfollowParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          await remoteDataSource.unfollow(params, token);
          return Right(NoParams());
        } on Failure catch (failure) {
          return Left(failure);
        }
      } else {
        return Left(TokenFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
