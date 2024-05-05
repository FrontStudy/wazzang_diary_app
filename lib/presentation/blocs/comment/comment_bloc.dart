import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/comment/comment.dart';
import '../../../domain/usecases/comment/add_comment_use_case.dart';

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

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUseCase _addCommentUseCase;

  CommentBloc(this._addCommentUseCase) : super(CommentInitial()) {
    on<AddComment>(_onAddComment);
  }

  void _onAddComment(AddComment event, Emitter<CommentState> emit) async {
    try {
      final currentState = state;
      // if (currentState is CommentInitial) {

      // }
      final result = await _addCommentUseCase(event.params);
      result.fold(
          (failure) => debugPrint(failure.toString()),
          (noParams) => emit(CommentLoaded(comments: const [
                // ...currentState.comments,
              ])));
    } catch (e) {}
  }
}
