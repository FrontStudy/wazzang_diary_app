import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/member/member_repository.dart';

class SignOutUseCase implements UseCase<NoParams, NoParams> {
  final MemberRepository repository;
  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.signOut();
  }
}
