part of 'search_diary_bloc.dart';

@immutable
abstract class SearchDiaryState extends Equatable {
  const SearchDiaryState();

  @override
  List<Object> get props => [];
}

class SearchDiaryInital extends SearchDiaryState {
  const SearchDiaryInital();
}

class SearchDiaryLoading extends SearchDiaryState {
  const SearchDiaryLoading();
}

class SearchDiaryLoaded extends SearchDiaryState {
  final List<DiaryDetails> diaryDetails;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const SearchDiaryLoaded(
      {required this.diaryDetails,
      this.hasReachedMax = false,
      this.isLoadingMore = false});

  SearchDiaryLoaded copyWith(
      {List<DiaryDetails>? diaryDetails,
      bool? hasReachedMax,
      bool? isLoadingMore}) {
    return SearchDiaryLoaded(
        diaryDetails: diaryDetails ?? this.diaryDetails,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }

  @override
  List<Object> get props => [diaryDetails, hasReachedMax, isLoadingMore];
}

class SearchDiaryFailed extends SearchDiaryState {
  final Failure failure;

  const SearchDiaryFailed(this.failure);
}
