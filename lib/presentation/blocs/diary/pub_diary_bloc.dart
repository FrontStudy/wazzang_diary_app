import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/diary/diary_details.dart';
import '../../../domain/usecases/diary/add_bookmark_use_case.dart';
import '../../../domain/usecases/diary/fetch_diary_detail_list_use_case.dart';
import '../../../domain/usecases/diary/like_diary_use_case.dart';
import '../../../domain/usecases/diary/remove_bookmark_use_case.dart';
import '../../../domain/usecases/diary/unlike_diary_use_case.dart';
import '../../../domain/usecases/follow/follow_use_case.dart';
import '../../../domain/usecases/follow/unfollow_use_case.dart';

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
  final List<DiaryDetails> diaryDetails;
  final bool hasReachedMax;
  final bool isLoadingMore;

  PubDiaryLoaded(
      {required this.diaryDetails,
      this.hasReachedMax = false,
      this.isLoadingMore = false});

  PubDiaryLoaded copyWith(
      {List<DiaryDetails>? diaryDetails,
      bool? hasReachedMax,
      bool? isLoadingMore}) {
    return PubDiaryLoaded(
        diaryDetails: diaryDetails ?? this.diaryDetails,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }

  @override
  List<Object?> get props => [diaryDetails, hasReachedMax, isLoadingMore];
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

class LikeDiary extends PubDiaryEvent {
  final LikeDiaryParams params;
  LikeDiary(this.params);
}

class UnlikeDiary extends PubDiaryEvent {
  final UnlikeDiaryParams params;
  UnlikeDiary(this.params);
}

class AddBookmark extends PubDiaryEvent {
  final AddBookmarkParams params;
  AddBookmark(this.params);
}

class RemoveBookmark extends PubDiaryEvent {
  final RemoveBookmarkParams params;
  RemoveBookmark(this.params);
}

class Follow extends PubDiaryEvent {
  final FollowParams params;
  Follow(this.params);
}

class Unfollow extends PubDiaryEvent {
  final UnfollowParams params;
  Unfollow(this.params);
}

class PubDiaryBloc extends Bloc<PubDiaryEvent, PubDiaryState> {
  final FetchPublicDiaryDetailListUseCase _fetchPublicDiaryDetailListUseCase;
  final LikeDiaryUseCase _likeDiaryUseCase;
  final UnlikeDiaryUseCase _unlikeDiaryUseCase;
  final AddBookmarkUseCase _addBookmarkUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;
  final FollowUseCase _followUseCase;
  final UnfollowUseCase _unfollowUseCase;
  PubDiaryBloc(
      this._fetchPublicDiaryDetailListUseCase,
      this._likeDiaryUseCase,
      this._unlikeDiaryUseCase,
      this._addBookmarkUseCase,
      this._removeBookmarkUseCase,
      this._followUseCase,
      this._unfollowUseCase)
      : super(PubDiaryInitial()) {
    on<FetchFirstDiaries>(_onFetchFirstDiaries);
    on<FetchMoreDiaries>(_onFetchMoreDiaries);
    on<LikeDiary>(_onLikeDiary);
    on<UnlikeDiary>(_onUnlikeDiary);
    on<AddBookmark>(_onAddBookmark);
    on<RemoveBookmark>(_onRemoveBookmark);
    on<Follow>(_onFollow);
    on<Unfollow>(_onUnfollow);
  }

  void _onFetchFirstDiaries(
      FetchFirstDiaries event, Emitter<PubDiaryState> emit) async {
    try {
      emit(PubDiaryLoading());
      final result = await _fetchPublicDiaryDetailListUseCase(
          const FetchPublicDiaryDetailsListParams(
              offset: 0, size: homeDiaryScrollLoadSize));
      result.fold((failure) => emit(PubDiaryFailed(failure)),
          (diaries) => emit(PubDiaryLoaded(
              diaryDetails: diaries,
              hasReachedMax: diaries.length < homeDiaryScrollLoadSize)));
    } catch (e) {
      emit(PubDiaryFailed(ExceptionFailure()));
    }
  }

  void _onFetchMoreDiaries(
      FetchMoreDiaries event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded &&
          !currentState.hasReachedMax &&
          !currentState.isLoadingMore) {
        emit(currentState.copyWith(isLoadingMore: true));
        final newParams = FetchPublicDiaryDetailsListParams(
            offset: (currentState.diaryDetails.length / homeDiaryScrollLoadSize)
                .floor()
                .toInt(),
            size: homeDiaryScrollLoadSize);
        final result = await _fetchPublicDiaryDetailListUseCase(newParams);
        result.fold(
          (failure) => emit(PubDiaryFailed(failure)),
          (diaries) {
            final allDiaries = currentState.diaryDetails + diaries;
            final hasReachedMax = diaries.length < homeDiaryScrollLoadSize;
            emit(PubDiaryLoaded(
                diaryDetails: allDiaries,
                hasReachedMax: hasReachedMax,
                isLoadingMore: false));
          },
        );
      }
    } catch (e) {
      emit(PubDiaryFailed(ExceptionFailure()));
    }
  }

  void _onLikeDiary(LikeDiary event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded) {
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
            emit(PubDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }

  void _onUnlikeDiary(UnlikeDiary event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded) {
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
            emit(PubDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }

  void _onAddBookmark(AddBookmark event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded) {
        final result = await _addBookmarkUseCase(event.params);
        result.fold(
          (failure) => debugPrint(failure.toString()),
          (noParams) {
            final updatedDiaries = currentState.diaryDetails.map((diary) {
              if (diary.id == event.params.diaryId) {
                return diary.copyWith(isBookmarked: true);
              } else {
                return diary;
              }
            }).toList();
            emit(PubDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }

  void _onRemoveBookmark(
      RemoveBookmark event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded) {
        final result = await _removeBookmarkUseCase(event.params);
        result.fold(
          (failure) => debugPrint(failure.toString()),
          (noParams) {
            final updatedDiaries = currentState.diaryDetails.map((diary) {
              if (diary.id == event.params.diaryId) {
                return diary.copyWith(isBookmarked: false);
              } else {
                return diary;
              }
            }).toList();
            emit(PubDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }

  void _onFollow(Follow event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded) {
        final result = await _followUseCase(event.params);
        result.fold(
          (failure) => debugPrint(failure.toString()),
          (noParams) {
            final updatedDiaries = currentState.diaryDetails.map((diary) {
              if (diary.authorId == event.params.followedId) {
                return diary.copyWith(isFollowing: true);
              } else {
                return diary;
              }
            }).toList();
            emit(PubDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }

  void _onUnfollow(Unfollow event, Emitter<PubDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is PubDiaryLoaded) {
        final result = await _unfollowUseCase(event.params);
        result.fold(
          (failure) => debugPrint(failure.toString()),
          (noParams) {
            final updatedDiaries = currentState.diaryDetails.map((diary) {
              if (diary.authorId == event.params.followedId) {
                return diary.copyWith(isFollowing: false);
              } else {
                return diary;
              }
            }).toList();
            emit(PubDiaryLoaded(diaryDetails: updatedDiaries));
          },
        );
      }
    } catch (e) {}
  }
}
