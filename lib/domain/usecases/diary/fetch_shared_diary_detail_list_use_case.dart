import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/diary/diary_details.dart';
import '../../repositories/diary/diary_repository.dart';

class FetchSharedDiaryDetailListUseCase
    implements UseCase<List<DiaryDetails>, FetchSharedDiaryDetailListParams> {
  final DiaryRepository _diaryRepository;

  FetchSharedDiaryDetailListUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, List<DiaryDetails>>> call(
      FetchSharedDiaryDetailListParams params) async {
    return await _diaryRepository.fetchSharedDiaryDetails(params);
  }
}

class FetchSharedDiaryDetailListParams {
  final int offset;
  final int size;

  FetchSharedDiaryDetailListParams({required this.offset, required this.size});
}
