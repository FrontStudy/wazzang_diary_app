import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import 'package:wazzang_diary/core/usecases/usecase.dart';

import 'package:wazzang_diary/domain/usecases/comment/add_comment_use_case.dart';

import '../../core/network/network_info.dart';
import '../../domain/repositories/comment/comment_repository.dart';
import '../datasources/local/member_local_data_source.dart';
import '../datasources/remote/comment_remote_data_source.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;
  final MemberLocalDataSource memberLocalDataSource;
  final NetworkInfo networkInfo;
  CommentRepositoryImpl(
      {required this.remoteDataSource,
      required this.memberLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NoParams>> addComment(AddCommentParams params) async {
    if (await networkInfo.isConnected) {
      if (await memberLocalDataSource.isTokenAvailable()) {
        String token = await memberLocalDataSource.getToken();
        try {
          await remoteDataSource.addComment(params, token);
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
