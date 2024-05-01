import '../member/member.dart';
import 'diary.dart';

class DiaryWithMember {
  final Diary diary;
  final Member author;

  DiaryWithMember({required this.diary, required this.author});

  static List<DiaryWithMember> mergeDiaryWithMember(
      List<Diary> diaries, List<Member> members) {
    List<DiaryWithMember> diaryWithMembers = [];
    for (Diary diary in diaries) {
      Member author;
      try {
        author = members.firstWhere((member) => member.id == diary.memberId);
        diaryWithMembers.add(DiaryWithMember(diary: diary, author: author));
      } catch (e) {}
    }

    return diaryWithMembers;
  }
}
