import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import 'package:wazzang_diary/domain/entities/diary/diary.dart';
import 'package:wazzang_diary/domain/usecases/diary/add_bookmark_use_case.dart';

import 'package:wazzang_diary/domain/usecases/diary/fetch_diary_list_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/remove_bookmark_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/unlike_diary_use_case.dart';

import '../../core/network/network_info.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/diary/diary_details.dart';
import '../../domain/repositories/diary/diary_repository.dart';
import '../../domain/usecases/diary/fetch_diary_detail_list_use_case.dart';
import '../../domain/usecases/diary/like_diary_use_case.dart';
import '../datasources/local/member_local_data_source.dart';
import '../datasources/remote/diary_remote_data_source.dart';

class DiaryRepositoryImpl extends DiaryRepository {
  final DiaryRemoteDataSource remoteDataSource;
  final MemberLocalDataSource memberLocalDataSource;
  final NetworkInfo networkInfo;

  DiaryRepositoryImpl(
      {required this.remoteDataSource,
      required this.memberLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Diary>>> fetchPublicDiaries(
      FetchPublicDiaryListParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getPubDiaries(params);

        return Right(response.data?.toEntityList() ?? []);
      } on Failure catch (failure) {
        debugPrint(failure.toString());
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<DiaryDetails>>> fetchPublicDiaryDetails(
      FetchPublicDiaryDetailsListParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          final response =
              await remoteDataSource.getPubDiaryDetails(params, token);

          return Right(response.data?.toEntityList() ?? []);
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
  Future<Either<Failure, NoParams>> likeDiary(LikeDiaryParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          await remoteDataSource.likeDiary(params, token);
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
  Future<Either<Failure, NoParams>> unlikeDiary(
      UnlikeDiaryParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          await remoteDataSource.unlikeDiary(params, token);
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
  Future<Either<Failure, NoParams>> addBookmark(
      AddBookmarkParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          await remoteDataSource.addBookmark(params, token);
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
  Future<Either<Failure, NoParams>> removeBookmark(
      RemoveBookmarkParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          await remoteDataSource.removeBookmark(params, token);
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
