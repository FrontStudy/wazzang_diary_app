part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final MemberDetailInfo info;
  final List<Diary> diaries;
  final bool hasReachedMax;
  final bool isLoadingMore;
  ProfileLoaded(
      {required this.info,
      required this.diaries,
      this.hasReachedMax = false,
      this.isLoadingMore = false});

  ProfileLoaded copyWith(
      {MemberDetailInfo? info,
      List<Diary>? diaries,
      bool? hasReachedMax,
      bool? isLoadingMore}) {
    return ProfileLoaded(
        info: info ?? this.info,
        diaries: diaries ?? this.diaries,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }

  @override
  List<Object> get props => [
        info,
        diaries,
        hasReachedMax,
        isLoadingMore,
      ];
}

class ProfileFailed extends ProfileState {
  final Failure failure;
  ProfileFailed(this.failure);
}
