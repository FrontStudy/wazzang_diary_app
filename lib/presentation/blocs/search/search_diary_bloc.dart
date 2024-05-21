import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/enums/sort_type.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/diary/diary_details.dart';
import '../../../domain/usecases/diary/fetch_diary_detail_list_use_case.dart';

part 'search_diary_event.dart';
part 'search_diary_state.dart';

class SearchDiaryBloc extends Bloc<SearchDiaryEvent, SearchDiaryState> {
  final FetchPublicDiaryDetailListUseCase _diaryDetailListUseCase;
  SearchDiaryBloc(this._diaryDetailListUseCase)
      : super(const SearchDiaryInital()) {
    on<FetchFirstDiaries>(_onFetchFirstDiaries);
    on<FetchMoreDiaries>(_onFetchMoreDiaries);
  }

  void _onFetchFirstDiaries(
      FetchFirstDiaries event, Emitter<SearchDiaryState> emit) async {
    try {
      emit(const SearchDiaryLoading());
      final result = await _diaryDetailListUseCase(
          FetchPublicDiaryDetailsListParams(
              offset: 0, size: searchPageScrollLoadSize, sort: event.sort));
      result.fold(
          (failure) => emit(SearchDiaryFailed(failure)),
          (diaries) => emit(SearchDiaryLoaded(
              diaryDetails: diaries,
              hasReachedMax: diaries.length < searchPageScrollLoadSize)));
    } catch (e) {
      emit(SearchDiaryFailed(ExceptionFailure()));
    }
  }

  void _onFetchMoreDiaries(
      FetchMoreDiaries event, Emitter<SearchDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is SearchDiaryLoaded &&
          !currentState.hasReachedMax &&
          !currentState.isLoadingMore) {
        emit(currentState.copyWith(isLoadingMore: true));
        final newParams = FetchPublicDiaryDetailsListParams(
            offset:
                (currentState.diaryDetails.length / searchPageScrollLoadSize)
                    .floor()
                    .toInt(),
            size: searchPageScrollLoadSize,
            sort: event.sort);
        final result = await _diaryDetailListUseCase(newParams);
        result.fold(
          (failure) => emit(SearchDiaryFailed(failure)),
          (diaries) {
            final allDiaries = currentState.diaryDetails + diaries;
            final hasReachedMax = diaries.length < searchPageScrollLoadSize;
            debugPrint("hasReachedMax : $hasReachedMax");
            emit(SearchDiaryLoaded(
                diaryDetails: allDiaries,
                hasReachedMax: hasReachedMax,
                isLoadingMore: false));
          },
        );
      }
    } catch (e) {
      emit(SearchDiaryFailed(ExceptionFailure()));
    }
  }
}
