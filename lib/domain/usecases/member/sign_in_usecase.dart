import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/member/member.dart';
import '../../repositories/member/member_repository.dart';

class SignInUseCase implements UseCase<Member, SignInParams> {
  final MemberRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, Member>> call(SignInParams params) async {
    return await repository.signIn(params);
  }
}

class SignInParams {
  final String email;
  final String passwd;

  const SignInParams({required this.email, required this.passwd});
}
