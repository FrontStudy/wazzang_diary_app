import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/domain/usecases/follow/follow_use_case.dart';
import 'package:wazzang_diary/domain/usecases/follow/unfollow_use_case.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

abstract class FollowRepository {
  Future<Either<Failure, NoParams>> follow(FollowParams params);

  Future<Either<Failure, NoParams>> unfollow(UnfollowParams params);
}
