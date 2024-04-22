import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/member/member.dart';
import '../../domain/repositories/member/member_repository.dart';
import '../../domain/usecases/member/sign_in_usecase.dart';
import '../../domain/usecases/member/sign_up_usecase.dart';

class MockMemberRepositoryImpl implements MemberRepository {
  @override
  Future<Either<Failure, Member>> signUp(SignUpParams params) async {
    return Right(Member(
        id: 1,
        email: 'test@test.com',
        name: 'Test User',
        nickname: 'Test Nickname'));
  }

  @override
  Future<Either<Failure, Member>> signIn(SignInParams params) async {
    return Right(Member(
        id: 1,
        email: 'test@test.com',
        name: 'Test User',
        nickname: 'Test Nickname'));
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    return Right(NoParams());
  }

  @override
  Future<Either<Failure, Member>> getCachedMembers() async {
    // return Right(Member(
    //     id: '1',
    //     email: 'test@test.com',
    //     name: 'Test User',
    //     nickname: 'Test Nickname'));
    return Left(ExceptionFailure());
  }
}
