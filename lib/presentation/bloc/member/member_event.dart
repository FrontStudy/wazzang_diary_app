part of 'member_bloc.dart';

abstract class MemberEvent {}

class SignInMember extends MemberEvent {
  final SignInParams params;
  SignInMember(this.params);
}

class SignUpMember extends MemberEvent {
  final SignUpParams params;
  SignUpMember(this.params);
}

class SignOutMember extends MemberEvent {}
