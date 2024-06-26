import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/member/member_detail_info.dart';
import '../../repositories/member/member_repository.dart';

class GetOwnMemberDetailInfoUseCase
    implements UseCase<MemberDetailInfo, NoParams> {
  final MemberRepository repository;
  GetOwnMemberDetailInfoUseCase(this.repository);

  @override
  Future<Either<Failure, MemberDetailInfo>> call(NoParams params) async {
    return await repository.getOwnMemberDetailInfo();
  }
}
