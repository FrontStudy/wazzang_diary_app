import '../../../domain/entities/diary/diary.dart';
import 'diary_model.dart';

class DiaryListModel {
  final List<DiaryModel> diaries;

  DiaryListModel({required this.diaries});

  Map<String, dynamic> toJson() => {
        'diaries': diaries.map((diary) => diary.toJson()).toList(),
      };

  factory DiaryListModel.fromJsonList(List<dynamic> json) {
    final List<DiaryModel> diaryList =
        json.map((diaryJson) => DiaryModel.fromJson(diaryJson)).toList();

    return DiaryListModel(diaries: diaryList);
  }

  List<Diary> toEntityList() {
    return diaries.map((model) => model.diary).toList();
  }
}
