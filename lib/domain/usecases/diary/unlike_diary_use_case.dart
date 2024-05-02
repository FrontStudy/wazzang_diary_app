import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/diary/diary_repository.dart';

class UnlikeDiaryUseCase implements UseCase<NoParams, UnlikeDiaryParams> {
  final DiaryRepository _diaryRepository;

  UnlikeDiaryUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, NoParams>> call(UnlikeDiaryParams params) async {
    return _diaryRepository.unlikeDiary(params);
  }
}

class UnlikeDiaryParams {
  final int diaryId;

  UnlikeDiaryParams({required this.diaryId});
}
