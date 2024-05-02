import 'package:dartz/dartz.dart';

import 'package:wazzang_diary/core/error/failures.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/diary/diary_repository.dart';

class AddBookmarkUseCase implements UseCase<NoParams, AddBookmarkParams> {
  final DiaryRepository _diaryRepository;

  AddBookmarkUseCase(this._diaryRepository);

  @override
  Future<Either<Failure, NoParams>> call(AddBookmarkParams params) async {
    return _diaryRepository.addBookmark(params);
  }
}

class AddBookmarkParams {
  final int diaryId;

  AddBookmarkParams({required this.diaryId});
}
