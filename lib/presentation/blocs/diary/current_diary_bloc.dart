import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/diary/diary_details.dart';
import '../../../domain/usecases/diary/add_bookmark_use_case.dart';
import '../../../domain/usecases/diary/fetch_diary_detail_use_case.dart';
import '../../../domain/usecases/diary/like_diary_use_case.dart';
import '../../../domain/usecases/diary/remove_bookmark_use_case.dart';
import '../../../domain/usecases/diary/unlike_diary_use_case.dart';
import '../../../domain/usecases/follow/follow_use_case.dart';
import '../../../domain/usecases/follow/unfollow_use_case.dart';

abstract class CurrentDiaryState extends Equatable {}

class CurrentDiaryInitial extends CurrentDiaryState {
  @override
  List<Object?> get props => [];
}

class CurrentDiaryLoading extends CurrentDiaryState {
  @override
  List<Object?> get props => [];
}

class CurrentDiaryLoaded extends CurrentDiaryState {
  final DiaryDetails diaryDetails;

  CurrentDiaryLoaded(this.diaryDetails);

  @override
  List<Object?> get props => [diaryDetails];
}

class CurrentDiaryFailed extends CurrentDiaryState {
  final Failure failure;

  CurrentDiaryFailed(this.failure);

  @override
  List<Object?> get props => [];
}

abstract class CurrentDiaryEvent {}

class FetchDiary extends CurrentDiaryEvent {
  final FetchDiaryDetailParams params;
  FetchDiary(this.params);
}

class LikeDiary extends CurrentDiaryEvent {
  final LikeDiaryParams params;
  LikeDiary(this.params);
}

class UnlikeDiary extends CurrentDiaryEvent {
  final UnlikeDiaryParams params;
  UnlikeDiary(this.params);
}

class AddBookmark extends CurrentDiaryEvent {
  final AddBookmarkParams params;
  AddBookmark(this.params);
}

class RemoveBookmark extends CurrentDiaryEvent {
  final RemoveBookmarkParams params;
  RemoveBookmark(this.params);
}

class Follow extends CurrentDiaryEvent {
  final FollowParams params;
  Follow(this.params);
}

class Unfollow extends CurrentDiaryEvent {
  final UnfollowParams params;
  Unfollow(this.params);
}

class CurrentDiaryBloc extends Bloc<CurrentDiaryEvent, CurrentDiaryState> {
  final FetchDiaryDetailUseCase _fetchDiaryDetailUseCase;
  final LikeDiaryUseCase _likeDiaryUseCase;
  final UnlikeDiaryUseCase _unlikeDiaryUseCase;
  final AddBookmarkUseCase _addBookmarkUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;
  final FollowUseCase _followUseCase;
  final UnfollowUseCase _unfollowUseCase;

  CurrentDiaryBloc(
      this._fetchDiaryDetailUseCase,
      this._likeDiaryUseCase,
      this._unlikeDiaryUseCase,
      this._addBookmarkUseCase,
      this._removeBookmarkUseCase,
      this._followUseCase,
    this._unfollowUseCase,
  )
      : super(CurrentDiaryInitial()) {
    on<FetchDiary>(_onFetchDiary);
    on<LikeDiary>(_onLikeDiary);
    on<UnlikeDiary>(_onUnlikeDiary);
    on<AddBookmark>(_onAddBookmark);
    on<RemoveBookmark>(_onRemoveBookmark);
    on<Follow>(_onFollow);
    on<Unfollow>(_onUnfollow);
  }

  void _onFetchDiary(FetchDiary event, Emitter<CurrentDiaryState> emit) async {
    try {
      emit(CurrentDiaryLoading());
      final result = await _fetchDiaryDetailUseCase(event.params);
      result.fold((failure) => emit(CurrentDiaryFailed(failure)),
          (diaryDetails) => emit(CurrentDiaryLoaded(diaryDetails)));
    } catch (e) {}
  }

  void _onLikeDiary(LikeDiary event, Emitter<CurrentDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is CurrentDiaryLoaded) {
        final result = await _likeDiaryUseCase(event.params);
        result.fold(
            (failure) => debugPrint(failure.toString()),
            (noParams) => emit(CurrentDiaryLoaded(
                currentState.diaryDetails.copyWith(isLiked: true))));
      }
    } catch (e) {}
  }

  void _onUnlikeDiary(
      UnlikeDiary event, Emitter<CurrentDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is CurrentDiaryLoaded) {
        final result = await _unlikeDiaryUseCase(event.params);
        result.fold(
            (failure) => debugPrint(failure.toString()),
            (noParams) => emit(CurrentDiaryLoaded(
                currentState.diaryDetails.copyWith(isLiked: false))));
      }
    } catch (e) {}
  }

  void _onAddBookmark(
      AddBookmark event, Emitter<CurrentDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is CurrentDiaryLoaded) {
        final result = await _addBookmarkUseCase(event.params);
        result.fold(
            (failure) => debugPrint(failure.toString()),
            (noParams) => emit(CurrentDiaryLoaded(
                currentState.diaryDetails.copyWith(isBookmarked: true))));
      }
    } catch (e) {}
  }

  void _onRemoveBookmark(
      RemoveBookmark event, Emitter<CurrentDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is CurrentDiaryLoaded) {
        final result = await _removeBookmarkUseCase(event.params);
        result.fold(
            (failure) => debugPrint(failure.toString()),
            (noParams) => emit(CurrentDiaryLoaded(
                currentState.diaryDetails.copyWith(isBookmarked: false))));
      }
    } catch (e) {}
  }

  void _onFollow(Follow event, Emitter<CurrentDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is CurrentDiaryLoaded) {
        final result = await _followUseCase(event.params);
        result.fold(
            (failure) => debugPrint(failure.toString()),
            (noParams) => emit(CurrentDiaryLoaded(
                currentState.diaryDetails.copyWith(isFollowing: true))));
      }
    } catch (e) {}
  }

  void _onUnfollow(Unfollow event, Emitter<CurrentDiaryState> emit) async {
    try {
      final currentState = state;
      if (currentState is CurrentDiaryLoaded) {
        final result = await _unfollowUseCase(event.params);
        result.fold(
            (failure) => debugPrint(failure.toString()),
            (noParams) => emit(CurrentDiaryLoaded(
                currentState.diaryDetails.copyWith(isFollowing: false))));
      }
    } catch (e) {}
  }
}
