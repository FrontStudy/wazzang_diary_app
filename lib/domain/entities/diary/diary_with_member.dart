import 'package:flutter/material.dart';

import '../member/member.dart';
import 'diary.dart';

class DiaryWithMember {
  final Diary diary;
  final Member? author;

  DiaryWithMember({required this.diary, required this.author});

  static List<DiaryWithMember> mergeDiaryWithMember(
      List<Diary> diaries, List<Member> members) {
    List<DiaryWithMember> diaryWithMembers = [];
    for (Diary diary in diaries) {
      Member? author;
      try {
        members.firstWhere((member) => member.id == diary.memberId);
      } catch (e) {
        debugPrint("diary : ${diaries.length}, member : ${members.length}");
        debugPrint(e.toString());
      }
      diaryWithMembers.add(DiaryWithMember(diary: diary, author: author));
    }

    return diaryWithMembers;
  }
}
