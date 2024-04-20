import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../entities/member/member.dart';
import '../../usecases/member/sign_up_usecase.dart';

abstract class MemberRepository {
  Future<Either<Failure, Member>> signUp(SignUpParams params);
}
