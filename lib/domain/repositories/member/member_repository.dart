import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_in_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/member/member.dart';
import '../../usecases/member/sign_up_usecase.dart';

abstract class MemberRepository {
  Future<Either<Failure, Member>> signUp(SignUpParams params);
  Future<Either<Failure, Member>> signIn(SignInParams params);
  Future<Either<Failure, NoParams>> signOut();
}
