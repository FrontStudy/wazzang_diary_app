import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/diary/diary_with_member.dart';
import '../../repositories/diary/diary_repository.dart';
import '../../repositories/member/member_repository.dart';

class FetchPublicDiaryListUseCase
    implements UseCase<List<DiaryWithMember>, FetchPublicDiaryListParams> {
  final DiaryRepository _diaryRepository;
  final MemberRepository _memberRepository;

  FetchPublicDiaryListUseCase(this._diaryRepository, this._memberRepository);

  @override
  Future<Either<Failure, List<DiaryWithMember>>> call(
      FetchPublicDiaryListParams params) async {
    final resultByDiaryRepo = await _diaryRepository.fetchPublicDiaries(params);

    return resultByDiaryRepo.fold(
      (failure) => Left(failure),
      (diaries) async {
        Set<int> authorIds = diaries.map((e) => e.memberId).toSet();

        final resultByMemberRepo =
            await _memberRepository.fetchMembersByIds(authorIds);
        return resultByMemberRepo.fold(
          (failure) => Left(failure),
          (members) {
            return Right(
                DiaryWithMember.mergeDiaryWithMember(diaries, members));
          },
        );
      },
    );
  }
}

class FetchPublicDiaryListParams {
  final int offset;
  final int size;

  const FetchPublicDiaryListParams({required this.offset, required this.size});
}
