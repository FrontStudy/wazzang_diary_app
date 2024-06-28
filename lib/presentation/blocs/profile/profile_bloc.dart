import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/diary/diary.dart';
import '../../../domain/entities/member/member_detail_info.dart';
import '../../../domain/usecases/diary/fetch_own_diary_list_use_case.dart';
import '../../../domain/usecases/member/get_own_member_detail_info_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetOwnMemberDetailInfoUseCase _getMemberInfoUseCase;
  final FetchOwnDiaryListUseCase _fetchOwnDiaryListUseCase;

  ProfileBloc(
    this._getMemberInfoUseCase,
    this._fetchOwnDiaryListUseCase,
  ) : super(ProfileInitial()) {
    on<FetchOwnMemberInfoAndFirstDiaries>(_onFetchOwnMemberInfoAndFirstDiaries);
    on<FetchMoreOwnDiaries>(_onFetchMoreOwnDiaries);
  }

  void _onFetchOwnMemberInfoAndFirstDiaries(
      FetchOwnMemberInfoAndFirstDiaries event,
      Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      List<Future> task = [];
      task.add(_getMemberInfoUseCase(NoParams()));
      task.add(_fetchOwnDiaryListUseCase(const FetchOwnDiaryListParams(
          offset: 0, size: profileDiaryScrollLoadSize)));
      final results = await Future.wait(task);

      results[0].fold((failure) {
        emit(ProfileFailed(failure));
        return;
      }, (info) {
        results[1].fold((failure) {},
            (diaries) => emit(ProfileLoaded(info: info, diaries: diaries)));
      });
    } catch (e) {
      emit(ProfileFailed(ExceptionFailure()));
    }
  }

  void _onFetchMoreOwnDiaries(
      FetchMoreOwnDiaries event, Emitter<ProfileState> emit) async {
    try {
      final currentState = state;
      if (currentState is ProfileLoaded &&
          !currentState.hasReachedMax &&
          !currentState.isLoadingMore) {
        emit(currentState.copyWith(isLoadingMore: true));
        final newParams = FetchOwnDiaryListParams(
            offset: (currentState.diaries.length / profileDiaryScrollLoadSize)
                .floor()
                .toInt(),
            size: homeDiaryScrollLoadSize);
        final result = await _fetchOwnDiaryListUseCase(newParams);
        result.fold(
          (failure) => emit(ProfileFailed(failure)),
          (diaries) {
            final allDiaries = currentState.diaries + diaries;
            final hasReachedMax = diaries.length < profileDiaryScrollLoadSize;
            emit(currentState.copyWith(
                diaries: allDiaries,
                hasReachedMax: hasReachedMax,
                isLoadingMore: false));
          },
        );
      }
    } catch (e) {
      emit(ProfileFailed(ExceptionFailure()));
    }
  }
}
