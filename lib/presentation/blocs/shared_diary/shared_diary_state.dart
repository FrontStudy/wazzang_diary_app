part of 'shared_diary_bloc.dart';

@immutable
abstract class SharedDiaryState extends Equatable {
  const SharedDiaryState();

  @override
  List<Object> get props => [];
}

class SharedDiaryInital extends SharedDiaryState {
  const SharedDiaryInital();
}

class SharedDiaryLoading extends SharedDiaryState {
  const SharedDiaryLoading();
}

class SharedDiaryLoaded extends SharedDiaryState {
  final List<DiaryDetails> diaryDetails;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const SharedDiaryLoaded(
      {required this.diaryDetails,
      this.hasReachedMax = false,
      this.isLoadingMore = false});

  SharedDiaryLoaded copyWith(
      {List<DiaryDetails>? diaryDetails,
      bool? hasReachedMax,
      bool? isLoadingMore}) {
    return SharedDiaryLoaded(
        diaryDetails: diaryDetails ?? this.diaryDetails,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }

  @override
  List<Object> get props => [diaryDetails, hasReachedMax, isLoadingMore];
}

class SharedDiaryFailed extends SharedDiaryState {
  final Failure failure;

  const SharedDiaryFailed(this.failure);
}
