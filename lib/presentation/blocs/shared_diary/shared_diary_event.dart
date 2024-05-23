part of 'shared_diary_bloc.dart';

abstract class SharedDiaryEvent {}

class FetchFirstDiaries extends SharedDiaryEvent {
  FetchFirstDiaries();
}

class FetchMoreDiaries extends SharedDiaryEvent {
  FetchMoreDiaries();
}

class LikeDiary extends SharedDiaryEvent {
  final LikeDiaryParams params;
  LikeDiary(this.params);
}

class UnlikeDiary extends SharedDiaryEvent {
  final UnlikeDiaryParams params;
  UnlikeDiary(this.params);
}
