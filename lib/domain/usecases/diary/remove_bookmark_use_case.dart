import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/diary/diary_repository.dart';

class RemoveBookmarkUseCase implements UseCase<NoParams, RemoveBookmarkParams> {
  final DiaryRepository _diaryRepository;

  RemoveBookmarkUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, NoParams>> call(RemoveBookmarkParams params) async {
    return _diaryRepository.removeBookmark(params);
  }
}

class RemoveBookmarkParams {
  final int diaryId;

  RemoveBookmarkParams({required this.diaryId});
}
