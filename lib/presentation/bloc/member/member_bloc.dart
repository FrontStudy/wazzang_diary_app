import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/member/member.dart';
import '../../../domain/usecases/member/sign_in_usecase.dart';
import '../../../domain/usecases/member/sign_out_usecase.dart';
import '../../../domain/usecases/member/sign_up_usecase.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  MemberBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
  ) : super(MemberInitial()) {
    on<SignInMember>(_onSignIn);
    on<SignUpMember>(_onSignUp);
    on<SignOutMember>(_onSignOut);
  }

  void _onSignIn(SignInMember event, Emitter<MemberState> emit) async {
    try {
      emit(MemberLoading());
      final result = await _signInUseCase(event.params);
      result.fold(
        (failure) => emit(MemberLoggedFail(failure)),
        (user) => emit(MemberLogged(user)),
      );
    } catch (e) {
      emit(MemberLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignUp(SignUpMember event, Emitter<MemberState> emit) async {
    try {
      emit(MemberLoading());
      final result = await _signUpUseCase(event.params);
      result.fold(
        (failure) => emit(MemberLoggedFail(failure)),
        (user) => emit(MemberLogged(user)),
      );
    } catch (e) {
      emit(MemberLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignOut(SignOutMember event, Emitter<MemberState> emit) async {
    try {
      emit(MemberLoading());
      await _signOutUseCase(NoParams());
      emit(MemberLoggedOut());
    } catch (e) {
      emit(MemberLoggedFail(ExceptionFailure()));
    }
  }
}
