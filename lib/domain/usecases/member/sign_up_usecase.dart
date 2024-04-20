import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/member/member.dart';
import '../../repositories/member/member_repository.dart';

class SignUpUseCase implements UseCase<Member, SignUpParams> {
  final MemberRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, Member>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}

class SignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  const SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}
