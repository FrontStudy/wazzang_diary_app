import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  CommentLoaded({required this.comments});

  @override
  List<Object?> get props => [comments];
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

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUseCase _addCommentUseCase;
  final FetchCommentUseCase _fetchCommentsUseCase;

  CommentBloc(this._addCommentUseCase, this._fetchCommentsUseCase)
      : super(CommentInitial()) {
    on<AddComment>(_onAddComment);
    on<FetchComment>(_onFetchComment);
  }

  void _onAddComment(AddComment event, Emitter<CommentState> emit) async {
    try {
      final diaryId = event.params.diaryId;
      await _addCommentUseCase(event.params);
      await _fetchComments(diaryId, emit);
    } catch (e) {}
  }

  void _onFetchComment(FetchComment event, Emitter<CommentState> emit) async {
    try {
      emit(CommentLoading());
      final result = await _fetchCommentsUseCase(event.params);
      result.fold(
        (failure) => emit(CommentFailed(failure: failure)),
        (comments) => emit(CommentLoaded(comments: comments)),
      );
    } catch (e) {
      debugPrint("_onFetchComment : $e");
    }
  }

  Future<void> _fetchComments(int diaryId, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    final result = await _fetchCommentsUseCase(
        FetchCommentParams(offset: 0, size: 10, diaryId: diaryId));
    result.fold(
      (failure) => emit(CommentFailed(failure: failure)),
      (comments) => emit(CommentLoaded(comments: comments)),
    );
  }
}
