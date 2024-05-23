import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/diary/diary_details.dart';
import '../../../domain/usecases/diary/fetch_shared_diary_detail_list_use_case.dart';
import '../../../domain/usecases/diary/like_diary_use_case.dart';
import '../../../domain/usecases/diary/unlike_diary_use_case.dart';

part 'shared_diary_event.dart';
part 'shared_diary_state.dart';

class SharedDiaryBloc extends Bloc<SharedDiaryEvent, SharedDiaryState> {
  final FetchSharedDiaryDetailListUseCase _diaryDetailListUseCase;
  final LikeDiaryUseCase _likeDiaryUseCase;
  final UnlikeDiaryUseCase _unlikeDiaryUseCase;

  SharedDiaryBloc(
    this._diaryDetailListUseCase,
    this._likeDiaryUseCase,
    this._unlikeDiaryUseCase,
  ) : super(const SharedDiaryInital()) {
    on<FetchFirstDiaries>(_onFetchFirsDiaries);
    on<FetchMoreDiaries>(_onFetchMoreDiaries);
    on<LikeDiary>(_onLikeDiary);
    on<UnlikeDiary>(_onUnlikeDiary);
  }

  void _onFetchFirsDiaries(
      FetchFirstDiaries event, Emitter<SharedDiaryState> emit) async {
    try {
      emit(const SharedDiaryLoading());
      final result = await _diaryDetailListUseCase(
          FetchSharedDiaryDetailListParams(
              offset: 0, size: sharedDiaryPageScrollLoadSize));
      result.fold(
          (failure) => emit(SharedDiaryFailed(failure)),
          (diaries) => emit(SharedDiaryLoaded(
              diaryDetails: diaries,
              hasReachedMax: diaries.length < searchPageScrollLoadSize)));
    } catch (e) {
      emit(SharedDiaryFailed(ExceptionFailure()));
    }
  }

  void _onFetchMoreDiaries(
      FetchMoreDiaries event, Emitter<SharedDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is SharedDiaryLoaded &&
          !currentState.hasReachedMax &&
          !currentState.isLoadingMore) {
        emit(currentState.copyWith(isLoadingMore: true));
        final newParams = FetchSharedDiaryDetailListParams(
            offset:
                (currentState.diaryDetails.length / searchPageScrollLoadSize)
                    .floor()
                    .toInt(),
            size: searchPageScrollLoadSize);
        final result = await _diaryDetailListUseCase(newParams);
        result.fold(
          (failure) => emit(SharedDiaryFailed(failure)),
          (diaries) {
            final allDiaries = currentState.diaryDetails + diaries;
            final hasReachedMax = diaries.length < searchPageScrollLoadSize;
            debugPrint("hasReachedMax : $hasReachedMax");
            emit(SharedDiaryLoaded(
                diaryDetails: allDiaries,
                hasReachedMax: hasReachedMax,
                isLoadingMore: false));
          },
        );
      }
    } catch (e) {
      emit(SharedDiaryFailed(ExceptionFailure()));
    }
  }

  void _onLikeDiary(LikeDiary event, Emitter<SharedDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is SharedDiaryLoaded) {
        final result = await _likeDiaryUseCase(event.params);
        result.fold(
          (failure) => debugPrint(failure.toString()),
          (noParams) {
            final updatedDiaries = currentState.diaryDetails.map((diary) {
              if (diary.id == event.params.diaryId) {
                return diary.copyWith(
                    isLiked: true, likeCount: diary.likeCount + 1);
              } else {
                return diary;
              }
            }).toList();
            emit(SharedDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }

  void _onUnlikeDiary(UnlikeDiary event, Emitter<SharedDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is SharedDiaryLoaded) {
        final result = await _unlikeDiaryUseCase(event.params);
        result.fold(
          (failure) => debugPrint(failure.toString()),
          (noParams) {
            final updatedDiaries = currentState.diaryDetails.map((diary) {
              if (diary.id == event.params.diaryId) {
                return diary.copyWith(
                    isLiked: false, likeCount: diary.likeCount - 1);
              } else {
                return diary;
              }
            }).toList();
            emit(SharedDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }
}
