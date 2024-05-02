import '../../../domain/entities/diary/diary_details.dart';
import 'diary_details_model.dart';

class DiaryDetailsListModel {
  final List<DiaryDetailsModel> diaryDetails;

  DiaryDetailsListModel({required this.diaryDetails});

  factory DiaryDetailsListModel.fromJsonList(List<dynamic> json) {
    final List<DiaryDetailsModel> diaryList =
        json.map((diaryJson) => DiaryDetailsModel.fromJson(diaryJson)).toList();

    return DiaryDetailsListModel(diaryDetails: diaryList);
  }

  List<DiaryDetails> toEntityList() {
    return diaryDetails.map((model) => model.diaryDetails).toList();
  }
}
