import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/domain/usecases/member/sign_in_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/member/member.dart';
import '../../entities/member/member_detail_info.dart';
import '../../usecases/member/sign_up_usecase.dart';

abstract class MemberRepository {
  Future<Either<Failure, Member>> signUp(SignUpParams params);
  Future<Either<Failure, Member>> signIn(SignInParams params);
  Future<Either<Failure, NoParams>> signOut();
  Future<Either<Failure, Member>> getCachedMembers();
  Future<Either<Failure, List<Member>>> fetchMembersByIds(Set<int> autorIds);
  Future<Either<Failure, MemberDetailInfo>> getOwnMemberDetailInfo();
}
