part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class FetchOwnMemberInfoAndFirstDiaries extends ProfileEvent {}

class FetchMoreOwnDiaries extends ProfileEvent {}
