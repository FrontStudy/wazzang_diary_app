import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import 'package:wazzang_diary/domain/entities/diary/diary.dart';

import 'package:wazzang_diary/domain/usecases/diary/fetch_diary_list_use_case.dart';

import '../../core/network/network_info.dart';
import '../../domain/repositories/diary/diary_repository.dart';
import '../datasources/remote/diary_remote_data_source.dart';

class DiaryRepositoryImpl extends DiaryRepository {
  final DiaryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DiaryRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

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
}
