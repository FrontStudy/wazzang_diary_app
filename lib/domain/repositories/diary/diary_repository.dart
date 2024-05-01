import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/domain/usecases/diary/fetch_diary_list_use_case.dart';

import '../../../core/error/failures.dart';
import '../../entities/diary/diary.dart';

abstract class DiaryRepository {
  Future<Either<Failure, List<Diary>>> fetchPublicDiaries(
      FetchPublicDiaryListParams params);
}
