part of 'search_diary_bloc.dart';

abstract class SearchDiaryEvent {}

class FetchFirstDiaries extends SearchDiaryEvent {
  final SortType sort;
  FetchFirstDiaries(this.sort);
}

class FetchMoreDiaries extends SearchDiaryEvent {
  final SortType sort;
  FetchMoreDiaries(this.sort);
}
