import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/diary/diary_with_member.dart';
import '../../../domain/usecases/diary/fetch_diary_list_use_case.dart';

abstract class PubDiaryState extends Equatable {}

class PubDiaryInitial extends PubDiaryState {
  @override
  List<Object?> get props => [];
}

class PubDiaryLoading extends PubDiaryState {
  @override
  List<Object?> get props => [];
}

class PubDiaryLoaded extends PubDiaryState {
  final List<DiaryWithMember> diariesWithMembers;
  final bool hasReachedMax;

  PubDiaryLoaded(this.diariesWithMembers, {this.hasReachedMax = false});

  @override
  List<Object?> get props => [];
}

class PubDiaryFailed extends PubDiaryState {
  final Failure failure;

  PubDiaryFailed(this.failure);

  @override
  List<Object?> get props => [];
}

abstract class PubDiaryEvent {}

class FetchFirstDiaries extends PubDiaryEvent {
  FetchFirstDiaries();
}

class FetchMoreDiaries extends PubDiaryEvent {
  FetchMoreDiaries();
}

class PubDiaryBloc extends Bloc<PubDiaryEvent, PubDiaryState> {
  final FetchPublicDiaryListUseCase _fetchPublicDiaryListUseCase;
  PubDiaryBloc(this._fetchPublicDiaryListUseCase) : super(PubDiaryInitial()) {
    on<FetchFirstDiaries>(_onFetchFirstDiaries);
    on<FetchMoreDiaries>(_onFetchMoreDiaries);
  }

  void _onFetchFirstDiaries(
      FetchFirstDiaries event, Emitter<PubDiaryState> emit) async {
    try {
      emit(PubDiaryLoading());
      final result = await _fetchPublicDiaryListUseCase(
          const FetchPublicDiaryListParams(
              offset: 0, size: homeDiaryInitinalLoadSize));
      result.fold((failure) => emit(PubDiaryFailed(failure)),
          (diaries) => emit(PubDiaryLoaded(diaries)));
    } catch (e) {
      emit(PubDiaryFailed(ExceptionFailure()));
    }
  }

  void _onFetchMoreDiaries(
      FetchMoreDiaries event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded) {
        final newParams = FetchPublicDiaryListParams(
            offset: currentState.diariesWithMembers.length,
            size: homeDiaryScrollLoadSize);
        final result = await _fetchPublicDiaryListUseCase(newParams);
        result.fold(
          (failure) => emit(PubDiaryFailed(failure)),
          (diaries) {
            final allDiaries = currentState.diariesWithMembers + diaries;
            final hasReachedMax = diaries.isEmpty;
            emit(PubDiaryLoaded(allDiaries, hasReachedMax: hasReachedMax));
          },
        );
      }
    } catch (e) {
      emit(PubDiaryFailed(ExceptionFailure()));
    }
  }
}
