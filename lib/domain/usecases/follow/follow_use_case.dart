import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/follow/follow_repository.dart';

class FollowUseCase implements UseCase<NoParams, FollowParams> {
  final FollowRepository _followRepository;

  FollowUseCase(this._followRepository);

  @override
  Future<Either<Failure, NoParams>> call(FollowParams params) async {
    return await _followRepository.follow(params);
  }
}

class FollowParams {
  final int followedId;

  FollowParams({required this.followedId});
}
