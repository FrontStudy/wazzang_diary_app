import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/member/member.dart';
import '../../repositories/member/member_repository.dart';

class GetCachedMemberUseCase implements UseCase<Member, NoParams> {
  final MemberRepository repository;
  GetCachedMemberUseCase(this.repository);

  @override
  Future<Either<Failure, Member>> call(NoParams params) async {
    return await repository.getCachedMembers();
  }
}
