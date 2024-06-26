import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../entities/diary/diary.dart';
import '../../repositories/diary/diary_repository.dart';

class FetchOwnDiaryListUseCase
    implements UseCase<List<Diary>, FetchOwnDiaryListParams> {
  final DiaryRepository _diaryRepository;

  FetchOwnDiaryListUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, List<Diary>>> call(
      FetchOwnDiaryListParams params) async {
    return _diaryRepository.fetchOwnDiaries(params);
  }
}

class FetchOwnDiaryListParams {
  final int offset;
  final int size;

  const FetchOwnDiaryListParams({required this.offset, required this.size});
}
