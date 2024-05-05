import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/comment/comment_repository.dart';

class AddCommentUseCase implements UseCase<NoParams, AddCommentParams> {
  final CommentRepository _repository;

  AddCommentUseCase(this._repository);
  @override
  Future<Either<Failure, NoParams>> call(AddCommentParams params) async {
    return await _repository.addComment(params);
  }
}

class AddCommentParams {
  final int diaryId;
  final String content;

  AddCommentParams({required this.diaryId, required this.content});
}
