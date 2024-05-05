import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/domain/usecases/comment/add_comment_use_case.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

abstract class CommentRepository {
  Future<Either<Failure, NoParams>> addComment(AddCommentParams params);
}
