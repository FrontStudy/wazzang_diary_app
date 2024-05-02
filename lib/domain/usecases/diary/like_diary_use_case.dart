import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/diary/diary_repository.dart';

class LikeDiaryUseCase implements UseCase<NoParams, LikeDiaryParams> {
  final DiaryRepository _diaryRepository;

  LikeDiaryUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, NoParams>> call(LikeDiaryParams params) async {
    return _diaryRepository.likeDiary(params);
  }
}

class LikeDiaryParams {
  final int diaryId;

  LikeDiaryParams({required this.diaryId});
}
