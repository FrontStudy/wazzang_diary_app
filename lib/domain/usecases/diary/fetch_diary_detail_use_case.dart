import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/diary/diary_details.dart';
import '../../repositories/diary/diary_repository.dart';

class FetchDiaryDetailUseCase
    implements UseCase<DiaryDetails, FetchDiaryDetailParams> {
  final DiaryRepository _diaryRepository;

  FetchDiaryDetailUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, DiaryDetails>> call(
      FetchDiaryDetailParams params) async {
    return await _diaryRepository.fetchDiaryDetail(params);
  }
}

class FetchDiaryDetailParams {
  final int diaryId;

  FetchDiaryDetailParams({required this.diaryId});
}
