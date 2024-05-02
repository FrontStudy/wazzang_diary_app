import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/diary/diary_details.dart';
import '../../repositories/diary/diary_repository.dart';

class FetchPublicDiaryDetailListUseCase
    implements UseCase<List<DiaryDetails>, FetchPublicDiaryDetailsListParams> {
  final DiaryRepository _diaryRepository;

  FetchPublicDiaryDetailListUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, List<DiaryDetails>>> call(
      FetchPublicDiaryDetailsListParams params) async {
    return await _diaryRepository.fetchPublicDiaryDetails(params);
  }
}

class FetchPublicDiaryDetailsListParams {
  final int offset;
  final int size;

  const FetchPublicDiaryDetailsListParams(
      {required this.offset, required this.size});
}
