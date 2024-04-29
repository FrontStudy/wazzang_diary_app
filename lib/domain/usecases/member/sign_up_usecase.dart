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
  final String email;
  final String passwd;
  final String nickname;
  final String name;
  final String gender;
  final String birthDate;
  final String? profilePicture;
  const SignUpParams({
    required this.email,
    required this.passwd,
    required this.nickname,
    required this.name,
    required this.gender,
    required this.birthDate,
    this.profilePicture,
  });
}
