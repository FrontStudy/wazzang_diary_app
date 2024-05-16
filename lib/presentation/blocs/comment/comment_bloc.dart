import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/comment/comment.dart';
import '../../../domain/usecases/comment/add_comment_use_case.dart';
import '../../../domain/usecases/comment/fetch_comment_use_case.dart';

abstract class CommentState extends Equatable {}

class CommentInitial extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentLoading extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentLoaded extends CommentState {
  final List<Comment> comments;
  final bool hasReachedMax;
  final bool isLoadingMore;

  CommentLoaded(
      {required this.comments,
      this.hasReachedMax = false,
      this.isLoadingMore = false});

  CommentLoaded copyWith(
      {List<Comment>? comments, bool? hasReachedMax, bool? isLoadingMore}) {
    return CommentLoaded(
        comments: comments ?? this.comments,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }

  @override
  List<Object?> get props => [comments, hasReachedMax, isLoadingMore];
}

class CommentFailed extends CommentState {
  final Failure failure;
  CommentFailed({required this.failure});

  @override
  List<Object?> get props => [];
}

abstract class CommentEvent {}

class AddComment extends CommentEvent {
  final AddCommentParams params;
  AddComment(this.params);
}

class FetchComment extends CommentEvent {
  final FetchCommentParams params;
  FetchComment(this.params);
}

class FetchMoreComment extends CommentEvent {
  FetchMoreComment();
}

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUseCase _addCommentUseCase;
  final FetchCommentUseCase _fetchCommentsUseCase;

  CommentBloc(this._addCommentUseCase, this._fetchCommentsUseCase)
      : super(CommentInitial()) {
    on<AddComment>(_onAddComment);
    on<FetchComment>(_onFetchComment);
    on<FetchMoreComment>(_onFetchMoreComment);
  }

  void _onAddComment(AddComment event, Emitter<CommentState> emit) async {
    try {
      final diaryId = event.params.diaryId;
      await _addCommentUseCase(event.params);
      await _fetchComments(
          offset: 0,
          size: commentPageScrollLoadSize,
          diaryId: diaryId,
          emit: emit);
    } catch (e) {}
  }

  void _onFetchComment(FetchComment event, Emitter<CommentState> emit) async {
    try {
      print('offset : ${event.params.offset}');
      print('size: ${event.params.size}');

      emit(CommentLoading());
      await _fetchComments(
          offset: event.params.offset,
          size: event.params.size,
          diaryId: event.params.diaryId,
          emit: emit);
    } catch (e) {
      debugPrint("_onFetchComment : $e");
    }
  }

  void _onFetchMoreComment(
      FetchMoreComment event, Emitter<CommentState> emit) async {
    try {
      print("moreComment");
      final currentState = state;
      if (currentState is CommentLoaded &&
          !currentState.hasReachedMax &&
          !currentState.isLoadingMore) {
        emit(currentState.copyWith(isLoadingMore: true));
        await _fetchComments(
            offset: (currentState.comments.length / commentPageScrollLoadSize)
                .floor()
                .toInt(),
            size: commentPageScrollLoadSize,
            diaryId: currentState.comments[0].diaryId,
            emit: emit);
      }
    } catch (e) {
      emit(CommentFailed(failure: ExceptionFailure()));
    }
  }

  Future<void> _fetchComments(
      {required int offset,
      required int size,
      required int diaryId,
      required Emitter<CommentState> emit}) async {
    final result = await _fetchCommentsUseCase(
        FetchCommentParams(
        offset: offset, size: commentPageScrollLoadSize, diaryId: diaryId));
    result.fold(
      (failure) => emit(CommentFailed(failure: failure)),
      (comments) {
        final currentState = state;
        if (currentState is CommentLoaded) {
          emit(CommentLoaded(
              comments: [...currentState.comments, ...comments],
              hasReachedMax: comments.length < commentPageScrollLoadSize,
              isLoadingMore: false));
        } else {
          emit(CommentLoaded(
              comments: comments,
              hasReachedMax: comments.length < commentPageScrollLoadSize));
        }
      },
    );
  }
}
