import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/comment/comment.dart';
import '../../repositories/comment/comment_repository.dart';

class FetchCommentUseCase
    implements UseCase<List<Comment>, FetchCommentParams> {
  final CommentRepository _repository;

  FetchCommentUseCase(this._repository);

  @override
  Future<Either<Failure, List<Comment>>> call(FetchCommentParams params) async {
    return await _repository.fetchComment(params);
  }
}

class FetchCommentParams {
  final int offset;
  final int size;
  final int diaryId;

  FetchCommentParams(
      {required this.offset, required this.size, required this.diaryId});
}
