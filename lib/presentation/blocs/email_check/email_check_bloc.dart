import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/usecases/signup/check_email_usecase.dart';

abstract class EmailCheckEvent {}

class VerifyEmail extends EmailCheckEvent {
  final CheckEmailParams params;

  VerifyEmail(this.params);
}

class RemoveEmail extends EmailCheckEvent {
  final String email;

  RemoveEmail(this.email);
}

abstract class EmailCheckState extends Equatable {
  final List<String> emails;
  const EmailCheckState(this.emails);

  @override
  List<Object> get props => [emails];
}

class EmailCheckInitial extends EmailCheckState {
  const EmailCheckInitial(super.emails);

  @override
  List<Object> get props => [emails];
}

class EmailCheckLoading extends EmailCheckState {
  const EmailCheckLoading(super.emails);

  @override
  List<Object> get props => [emails];
}

class EmailCheckSuccess extends EmailCheckState {
  const EmailCheckSuccess(super.emails);

  @override
  List<Object> get props => [emails];
}

class EmailCheckFailure extends EmailCheckState {
  final Failure failure;
  const EmailCheckFailure(this.failure, super.emails);

  @override
  List<Object> get props => [failure, emails];
}

class EmailCheckBloc extends Bloc<EmailCheckEvent, EmailCheckState> {
  final CheckEmailUseCase _checkEmailUseCase;
  EmailCheckBloc(this._checkEmailUseCase) : super(const EmailCheckInitial([])) {
    on<VerifyEmail>(_verifiyEmail);
    on<RemoveEmail>(_removeEmail);
  }

  void _verifiyEmail(VerifyEmail event, Emitter<EmailCheckState> emit) async {
    final currentState = state;
    if (currentState is EmailCheckLoading) return;
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (!emailRegex.hasMatch(event.params.email)) {
      emit(EmailCheckFailure(ValidationFailure(), currentState.emails));
      return;
    }
    try {
      emit(EmailCheckLoading(currentState.emails));
      final result = await _checkEmailUseCase(event.params);
      result.fold(
          (failure) => emit(EmailCheckFailure(failure, currentState.emails)),
          (success) => success
              ? emit(EmailCheckSuccess(
                  [...currentState.emails, event.params.email]))
              : emit(EmailCheckFailure(
                  MemberNotFoundFailure(), currentState.emails)));
    } catch (e) {
      emit(EmailCheckFailure(ExceptionFailure(), currentState.emails));
    }
  }

  void _removeEmail(RemoveEmail event, Emitter<EmailCheckState> emit) {
    if (state is EmailCheckLoading) return;
    List<String> emails = [...state.emails];
    emails.remove(event.email);
    emit(EmailCheckSuccess(emails));
  }
}
