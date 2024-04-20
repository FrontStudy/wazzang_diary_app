part of 'member_bloc.dart';

@immutable
abstract class MemberState extends Equatable {}

class MemberInitial extends MemberState {
  @override
  List<Object> get props => [];
}

class MemberLoading extends MemberState {
  @override
  List<Object> get props => [];
}

class MemberLogged extends MemberState {
  final Member member;
  MemberLogged(this.member);
  @override
  List<Object> get props => [member];
}

class MemberLoggedFail extends MemberState {
  final Failure failure;
  MemberLoggedFail(this.failure);
  @override
  List<Object> get props => [failure];
}

class MemberLoggedOut extends MemberState {
  @override
  List<Object> get props => [];
}
