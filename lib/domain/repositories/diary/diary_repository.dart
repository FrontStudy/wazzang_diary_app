import 'package:dartz/dartz.dart';
import 'package:wazzang_diary/core/usecases/usecase.dart';
import 'package:wazzang_diary/domain/usecases/diary/add_bookmark_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/fetch_diary_detail_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/fetch_diary_list_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/fetch_own_diary_list_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/fetch_shared_diary_detail_list_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/like_diary_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/remove_bookmark_use_case.dart';
import 'package:wazzang_diary/domain/usecases/diary/unlike_diary_use_case.dart';

import '../../../core/error/failures.dart';
import '../../entities/diary/diary.dart';
import '../../entities/diary/diary_details.dart';
import '../../usecases/diary/fetch_diary_detail_list_use_case.dart';

abstract class DiaryRepository {
  Future<Either<Failure, List<Diary>>> fetchPublicDiaries(
      FetchPublicDiaryListParams params);

  Future<Either<Failure, List<DiaryDetails>>> fetchPublicDiaryDetails(
      FetchPublicDiaryDetailsListParams params);

  Future<Either<Failure, NoParams>> likeDiary(LikeDiaryParams params);

  Future<Either<Failure, NoParams>> unlikeDiary(UnlikeDiaryParams params);

  Future<Either<Failure, NoParams>> removeBookmark(RemoveBookmarkParams params);

  Future<Either<Failure, NoParams>> addBookmark(AddBookmarkParams params);

  Future<Either<Failure, DiaryDetails>> fetchDiaryDetail(
      FetchDiaryDetailParams params);

  Future<Either<Failure, List<DiaryDetails>>> fetchSharedDiaryDetails(
      FetchSharedDiaryDetailListParams params);

  Future<Either<Failure, List<Diary>>> fetchOwnDiaries(
      FetchOwnDiaryListParams params);
}
