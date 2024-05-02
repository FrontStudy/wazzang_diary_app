import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/follow/follow_repository.dart';

class UnfollowUseCase implements UseCase<NoParams, UnfollowParams> {
  final FollowRepository _followRepository;

  UnfollowUseCase(this._followRepository);

  @override
  Future<Either<Failure, NoParams>> call(UnfollowParams params) async {
    return await _followRepository.unfollow(params);
  }
}

class UnfollowParams {
  final int followedId;

  UnfollowParams({required this.followedId});
}
