import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/usecases/signup/check_email_usecase.dart';

abstract class CheckEmailState extends Equatable {}

class EmailCheckInitial extends CheckEmailState {
  @override
  List<Object> get props => [];
}

class EmailCheckSuccess extends CheckEmailState {
  @override
  List<Object> get props => [];
}

class EmailCheckLoading extends CheckEmailState {
  @override
  List<Object> get props => [];
}

class EmailCheckFail extends CheckEmailState {
  final Failure failure;
  EmailCheckFail(this.failure);
  @override
  List<Object> get props => [];
}

abstract class CheckEmailEvent {}

class CheckEmail extends CheckEmailEvent {
  final CheckEmailParams params;
  CheckEmail(this.params);
}

class CheckEmailBloc extends Bloc<CheckEmailEvent, CheckEmailState> {
  final CheckEmailUseCase _checkEmailUseCase;
  int requestIndex = 0;
  CheckEmailBloc(this._checkEmailUseCase) : super(EmailCheckInitial()) {
    on<CheckEmail>(_onCheckEmail);
  }

  void _onCheckEmail(CheckEmail event, Emitter<CheckEmailState> emit) async {
    final currentIndex = ++requestIndex;
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (!emailRegex.hasMatch(event.params.email)) {
      emit(EmailCheckFail(ValidationFailure()));
      return;
    }

    try {
      emit(EmailCheckLoading());
      final result = await _checkEmailUseCase(event.params);
      if (requestIndex != currentIndex) return;
      result.fold(
        (failure) => emit(EmailCheckFail(failure)),
        (isDuplicate) => isDuplicate
            ? emit(EmailCheckFail(DuplicateFailure()))
            : emit(EmailCheckSuccess()),
      );
    } catch (e) {
      emit(EmailCheckFail(ExceptionFailure()));
    }
  }
}
